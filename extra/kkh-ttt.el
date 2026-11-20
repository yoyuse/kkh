;;; kkh-ttt.el --- Oyayubi Kanchoku for kkh.el       -*- lexical-binding: t; -*-

;; Copyright (C) 2026  YUSE Yosihiro

;; Author: YUSE Yosihiro <yoyuse@gmail.com>
;; Keywords: input method, Japanese

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; ** 概要
;; - kkh.el 上で親指漢直を利用する実験的機能です
;; - ひらがなは USかな で, 漢字は SPC シフトにより TT-code で入力します
;; - カタカナは, ひらがなで入力してカタカナ確定するか, TT-code で入力します
;;
;; ** 設定
;; *** ttt.el の設定
;; - ttt.el (https://github.com/yoyuse/ttt) をインストール・設定します
;;
;; *** SPC シフトの設定
;; - Karabiner-Elements などを利用して, 次のいずれかの設定をします
;; - SPC (親指キー) でシフトしたときに | (VERTICAL LINE) を前置する
;;   - 例: SPC を押しながら l 4 z / と入力すると | l | 4 | z | / を送る
;; - あるいは, SPC プレス時に F14 を, SPC リリース時に F15 を Emacs に送る
;;   - 例: SPC を押しながら l 4 z / と入力すると f14 l 4 z / f15 を送る
;;
;; *** kkh-ttt.el の設定
;; - kkh-ttt.el を load-path の通ったところに置き, init.el に以下を追記します
;;
;;     ;; 親指漢直
;;     (when (and (require 'kkh nil t)
;;                (require 'ttt nil t))
;;       (require 'kkh-ttt)
;;       ;; 親指漢直の有効化
;;       (setq kkh-ttt-enabled t)
;;       ;; 無変換/変換 で ひらがな確定/カタカナ確定
;;       (let ((map (quail-conversion-keymap)))
;;         (define-key map (kbd "<muhenkan>") 'kkh-translit-commit-hiragana)
;;         (define-key map (kbd "<henkan>") 'kkh-translit-commit-katakana))
;;       (let ((map kkh-keymap))
;;         (define-key map (kbd "<muhenkan>") 'kkh-conv-hiragana)
;;         (define-key map (kbd "<henkan>") 'kkh-conv-katakana)))
;;
;; ** 使用法
;; - SPC を押しながら TT-code を入力, SPC を離して C-u で漢直入力します
;; - 入力中に C-\ で親指漢直 ON/OFF をトグルします
;; - 補換 (補助変換) は, うまくいけば動作するかもしれません
;;
;; ** 参照
;; - 「親指漢直」とは何か？(1) - 錬金術師の実験室
;; - https://web.archive.org/web/20211204133509/http://homeposition.net/~m%28as%29m/blog/2015/08/whats-oyayubi-kanchoku-1.html
;;
;; - DvorakJとGoogle日本語入力の連携による各種キー配列への対応 - 錬金術師の実験室
;; - https://web.archive.org/web/20211204141027/http://homeposition.net/~m%28as%29m/blog/2015/12/15-advent.html

;;; Code:

(require 'ttt)

(defvar kkh-ttt-enabled nil "非 nil のとき, 親指漢直を使う.")
(defvar kkh-ttt--with-reduction nil)

(defun kkh-ttt-raw-code-to-kanji (raw-code)
  "親指漢直コード RAW-CODE を漢字に変換した新しい文字列を返す.
`kkh-ttt--with-reduction' が非 nil なら, 補助変換も行う."
  (save-match-data
    (let* ((src (replace-regexp-in-string "|\\(.\\)" "\\1" raw-code))
           (ttt-keep-remainder nil)
           (dst (ttt--decode-string src))
           (remain (replace-regexp-in-string "\\(.\\)" "|\\1" ttt--remain))
           (dst (concat dst remain)))
      (if kkh-ttt--with-reduction
          (ttt-reduce dst)
        (ttt--invalidate-all dst)))))

(defun kkh-ttt-to-alist (str)
  "ASCII 文字列 STR から ((KANA . ASCII) ...) の連想配列を作る."
  (let ((case-fold-search nil)
        kana ascii head alist
        re (kkh-rules-pattern))
    (save-match-data
      (setq re (replace-regexp-in-string
                (regexp-quote "\\(.*?\\)\\(")
                "\\&\\\\(\\\\(?:|.\\\\)+\\\\)\\\\|" ;XXX
                (kkh-rules-pattern)))
      (while (string-match re str)
        (setq head (match-string 1 str)
              ascii (match-string 2 str)
              code (match-string 3 str)
              str (match-string 4 str)
              kana (cadr (assoc ascii (kkh-rules)))
              kanji (kkh-ttt-raw-code-to-kanji ascii)
              kana (if (string-match-p "^|." ascii) kanji kana))
        ;; XXX: for roman
        (when (string-match "^っ\\(.\\)$" kana)
          (let ((ch (match-string 1 kana)))
            (when (string= ascii (concat ch ch))
              (setq ascii ch
                    str (concat ch str)
                    kana "っ"))))
        ;; /XXX
        (when (not (string= head ""))
          (setq alist (append alist (mapcar (lambda (c)
                                              (let ((ch (char-to-string c)))
                                                (cons ch ch)))
                                            (string-to-list head)))))
        (setq alist (append alist (list (cons kana ascii)))))
      (when (not (string= str ""))
        (setq alist (append alist (mapcar (lambda (c)
                                            (let ((ch (char-to-string c)))
                                              (cons ch ch)))
                                          (string-to-list str)))))
      alist)))


(defun kkh-ttt-to-alist-ad (orig-fun &rest args)
  "`kkh-to-alist' への advice."
  (if kkh-ttt-enabled
      (apply #'kkh-ttt-to-alist args) ; XXX
    (apply orig-fun args)))

(advice-add 'kkh-to-alist :around #'kkh-ttt-to-alist-ad)

(defun kkh-ttt-with-reduction-ad (orig-fun &rest args)
  "`kkh-ttt--with-reduction' を `t' にする advice."
  (let ((kkh-ttt--with-reduction t))
    (apply orig-fun args)))

(dolist (fun '(kkh-translit-commit-hiragana
               kkh-translit-commit-katakana
               kkh-translit-commit-zenkaku
               kkh-translit-commit-hankaku
               kkh-reconvert))
  (advice-add fun :around #'kkh-ttt-with-reduction-ad))

(defun kkh-ttt-translit-backward-delete-char-ad (orig-fun &rest args)
  "`kkh-translit-backward-delete-char' への advice."
  (if (not kkh-ttt-enabled)
      (apply orig-fun args)
    (save-match-data
      (apply orig-fun args)
      (when (looking-back "|" (overlay-start quail-conv-overlay))
        (apply orig-fun args)))))

(advice-add 'kkh-translit-backward-delete-char :around #'kkh-ttt-translit-backward-delete-char-ad)

(defun kkh-ttt-backward-scan-pattern-ad (orig-fun &rest args)
  "`kkh-backward-scan-pattern' への advice."
  (concat "\\("
          (mapconcat (lambda (s) (regexp-quote s))
                     (mapcar (lambda (rule) (car rule)) (kkh-rules))
                     "\\|")
          (if kkh-ttt-enabled "\\||." "") ; XXX
          "\\)+$"))

(advice-add 'kkh-backward-scan-pattern :around #'kkh-ttt-backward-scan-pattern-ad)

(defun kkh-ttt-toggle-enabled()
  "`kkh-ttt-enabled' をトグルする."
  (interactive)
  (setq kkh-ttt-enabled (not kkh-ttt-enabled))
  (message "Kanchoku %s" (if kkh-ttt-enabled "enabled" "disabled"))
  (kkh-preview-set-guidance-str))

(define-key (quail-conversion-keymap) (kbd "C-\\") 'kkh-ttt-toggle-enabled)

;;; kkh-ttt-space - SPC キーによるシフト

(defvar kkh-ttt-space-down nil "SPC キーが押されているかどうか.")

(defun kkh-ttt-space-press ()
  "SPC キーを押す."
  (interactive)
  (setq kkh-ttt-space-down t))

(defun kkh-ttt-space-release ()
  "SPC キーを離す."
  (interactive)
  (setq kkh-ttt-space-down nil))

(define-key global-map (kbd "<f14>") 'kkh-ttt-space-press)
(define-key global-map (kbd "<f15>") 'kkh-ttt-space-release)
(define-key isearch-mode-map (kbd "<f14>") 'kkh-ttt-space-press)
(define-key isearch-mode-map (kbd "<f15>") 'kkh-ttt-space-release)
(define-key (quail-conversion-keymap) (kbd "<f14>") 'kkh-ttt-space-press)
(define-key (quail-conversion-keymap) (kbd "<f15>") 'kkh-ttt-space-release)

(defun kkh-ttt-space-msb-to-bar (str)
  "文字列 STR 中の MSB を \"|\"-prefix に置き換えた新しい文字列を返す."
  (mapconcat (lambda (c)
               (if (and (< (+ 32 128) c) (< c (+ 128 128)))
                   (list ?| (- c 128))
                 (list c)))
             str))

;; 各 ASCII 文字 [!-~] について MSB から "|"-prefix への translation.
(let ((c 33))                           ; (c 32)
  (while (< c 127)
    (quail-defrule (char-to-string (+ c 128))
                   (vector (concat "|" (char-to-string c))))
    (setq c (1+ c))))

(defun kkh-ttt-space-quail-self-insert-command-ad (orig-fun &rest args)
  "`quail-self-insert-command' への advice.
SPC キーによるシフトで MSB を付与する."
  (interactive "*")
  (setq quail-current-key
        ;; (concat quail-current-key (char-to-string last-command-event)))
        (concat quail-current-key
                (if (and (equal current-input-method "japanese-kkh")
                         kkh-ttt-enabled
                         kkh-ttt-space-down)
                    (char-to-string (+ 128 last-command-event))
                  (char-to-string last-command-event))))
  (or (catch 'quail-tag
        (quail-update-translation (quail-translate-key))
        t)
      ;; If someone throws for `quail-tag' by value nil, we exit from
      ;; translation mode.
      (setq quail-translating nil)))

(advice-add 'quail-self-insert-command :around #'kkh-ttt-space-quail-self-insert-command-ad)

;;; kkh-ttt-zenkaku-hankaku - ASCII 文字を入力するための全角/半角変変換

;; TT-code で入力できる半角英数記号文字は,
;;   ! ? % ( ) 1 2 3 4 5 6 7 8 9 0
;; の 15 字あるが, このうち ! を除く 14 字は, USかな打鍵と解釈されて
;;   ・ ぇ ょ を ぬ ふ あ う え お や ゆ よ わ
;; に化けてしまう.
;; そこで, これらの文字は TT-code 変換したときに全角に退避しておいて,
;; USかな 変換したあとで半角に復元するようにする.

(defvar kkh-ttt-zenkaku-hankaku t
  "非 nil のとき, 親指漢直で ASCII 文字を入力するために全角/半角変換を行う.")

(defvar kkh-ttt-zenkaku-hankaku-alist
  '((?1 . ?１) (?2 . ?２) (?3 . ?３) (?4 . ?４) (?5 . ?５)
    (?6 . ?６) (?7 . ?７) (?8 . ?８) (?9 . ?９) (?0 . ?０)
    (?! . ?！) (?% . ?％) (?\( . ?\（) (?\) . ?\）) (?? . ?？))
  "全角/半角変換を行うための対応表の alist.")

(defun kkh-ttt-zenkaku-ad (orig-fun &rest args)
  "全角変換する advice."
  (let ((dst (apply orig-fun args)))
    (if (and kkh-ttt-enabled kkh-ttt-zenkaku-hankaku)
        (save-match-data
          (mapconcat
           (lambda (c)
             (char-to-string
              (or (cdr-safe (assq c kkh-ttt-zenkaku-hankaku-alist)) c)))
           (string-to-list dst)))
      dst)))

(advice-add 'kkh-ttt-raw-code-to-kanji :around #'kkh-ttt-zenkaku-ad)

(defun kkh-ttt-hankaku-ad (orig-fun &rest args)
  "半角変換する advice."
  (let ((dst (apply orig-fun args)))
    (if (and kkh-ttt-enabled kkh-ttt-zenkaku-hankaku)
        (save-match-data
          (mapconcat
           (lambda (c)
             (char-to-string
              (or (car-safe (rassq c kkh-ttt-zenkaku-hankaku-alist)) c)))
           (string-to-list dst)))
      dst)))

(advice-add 'kkh-to-kana :around #'kkh-ttt-hankaku-ad)

(provide 'kkh-ttt)
;;; kkh-ttt.el ends here
