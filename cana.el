;;; cana.el --- JIS kana input on US keyboard        -*- lexical-binding: t; -*-

;; Copyright (C) 2025  YUSE Yosihiro

;; Author: YUSE Yosihiro <yoyuse@gmail.com>
;; Keywords: i18n, mule, multilingual, input method, Japanese

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

;; This file is based on japanese.el and kkc.el

;; ;;; japanese.el --- Quail package for inputting Japanese  -*- lexical-binding: t; -*-
;;
;; ;; Copyright (C) 2001-2022 Free Software Foundation, Inc.
;; ;; Copyright (C) 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2005,
;; ;;   2006, 2007, 2008, 2009, 2010, 2011
;; ;;   National Institute of Advanced Industrial Science and Technology (AIST)
;; ;;   Registration Number H14PRO021

;; ;;; kkc.el --- Kana Kanji converter  -*- lexical-binding: t; -*-
;;
;; ;; Copyright (C) 1997-1998, 2001-2022 Free Software Foundation, Inc.
;; ;; Copyright (C) 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004,
;; ;;   2005, 2006, 2007, 2008, 2009, 2010, 2011
;; ;;   National Institute of Advanced Industrial Science and Technology (AIST)
;; ;;   Registration Number H14PRO021

;;; Setup:

;; (when (require 'cana nil t)
;;   (setq default-input-method "cana")
;;   ;; 次候補キー 2 回で候補リストを表示
;;   ;; (setq ckc-show-conversion-list-count 2)
;;   ;; カーソル色を Teal 400 に
;;   ;; (setq cana-cursor-color "#26A69A")
;;   ;; C-変換 で再変換
;;   ;; (define-key global-map (kbd "C-<henkan>") 'cana-reconvert)
;;   ;; C-無変換 でかなプレビューをトグル
;;   ;; (let ((map (quail-conversion-keymap)))
;;   ;;   (define-key map (kbd "C-<muhenkan>") 'cana-preview-toggle))
;;   )

;;; Code:

;;; cana

(require 'quail)

(defvar cana-rules
  '(( "3" "あ") ( "e" "い") ( "4" "う") ( "5" "え") ( "6" "お")
    ( "t" "か") ( "g" "き") ( "h" "く") ( "'" "け") ( "b" "こ")
    ( "x" "さ") ( "d" "し") ( "r" "す") ( "p" "せ") ( "c" "そ")
    ( "q" "た") ( "a" "ち") ( "z" "つ") ( "w" "て") ( "s" "と")
    ( "u" "な") ( "i" "に") ( "1" "ぬ") ( "," "ね") ( "k" "の")
    ( "f" "は") ( "v" "ひ") ( "2" "ふ") ( "=" "へ") ( "-" "ほ")
    ( "j" "ま") ( "n" "み") ("\\" "む") ( "/" "め") ( "m" "も")
    ( "7" "や")             ( "8" "ゆ")             ( "9" "よ")
    ( "o" "ら") ( "l" "り") ( "." "る") ( ";" "れ") ( "`" "ろ")
    ( "0" "わ") ( ")" "を") ( "y" "ん")
    ( "#" "ぁ") ( "E" "ぃ") ( "$" "ぅ") ( "%" "ぇ") ( "^" "ぉ")
    ( "Z" "っ") ( "&" "ゃ") ( "*" "ゅ") ( "(" "ょ")
    ( "_" "ー") ( "{" "「") ( "}" "」") ( "<" "、") ( ">" "。")
    ( "?" "・") ( "[" "゛") ( "]" "゜")

    ("t[" "が") ("g[" "ぎ") ("h[" "ぐ") ("'[" "げ") ("b[" "ご")
    ("x[" "ざ") ("d[" "じ") ("r[" "ず") ("p[" "ぜ") ("c[" "ぞ")
    ("q[" "だ") ("a[" "ぢ") ("z[" "づ") ("w[" "で") ("s[" "ど")
    ("f[" "ば") ("v[" "び") ("2[" "ぶ") ("=[" "べ") ("-[" "ぼ")
    ("f]" "ぱ") ("v]" "ぴ") ("2]" "ぷ") ("=]" "ぺ") ("-]" "ぽ")
    ("0]" "ゎ") ("e]" "ゐ")             ("5]" "ゑ")
    ("4[" "ヴ") ("t]" "ヵ") ("']" "ヶ")

    ("~1" "○") ("~!" "●")
    ("~2" "▽") ("~@" "▼")
    ("~3" "△") ("~#" "▲")
    ("~4" "□") ("~$" "■")
    ("~5" "◇") ("~%" "◆")
    ("~6" "☆") ("~^" "★")
    ("~7" "◎") ("~&" "£")
    ("~8" "¢") ("~*" "×")
    ("~9" "♂") ("~(" "【")
    ("~0" "♀") ("~)" "】")
    ("~-" "〜") ("~_" "∴")
    ("~=" "≠") ("~+" "±")
    ("~\\" "＼") ("~|" "‖")
    ("~`" "´") ("~~" "¨")

    ("~q" "《") ("~Q" "〈")
    ("~w" "》") ("~W" "〉")
    ("~r" "々") ("~R" "仝")
    ("~t" "〆") ("~T" "§")
    ("~Y" "￥")                         ; 円記号
    ("~p" "〒") ("~P" "↑")
    ("~[" "『") ("~{" "〔")
    ("~]" "』") ("~}" "〕")

    ("~s" "ヽ") ("~S" "ヾ")
    ("~d" "ゝ") ("~D" "ゞ")
    ("~f" "〃") ("~F" "→")
    ("~g" "‐") ("~G" "—")
    ("~h" "←")
    ("~j" "↓")
    ("~k" "↑")
    ("~l" "→")
    ("~;" "゛") ("~:" "゜")
    ("~'" "‘") ("~\"" "“")

    ("~x" "’") ("~X" "”")             ; 全角引用符
    ("~c" "〇") ("~C" "℃")
    ("~v" "※") ("~V" "÷")
    ("~b" "°") ("~B" "←")
    ("~n" "′") ("~N" "↓")
    ("~m" "″") ("~M" "〓")
    ("~," "‥") ("~<" "≦")
    ("~." "…") ("~>" "≧")
    ("~/" "／") ("~?" "∞"))            ; 全角スラッシュ
  "ASCII 文字列とかなの対応の連想配列.")

;; ASCII 文字列の長さで降順ソートしておく
(setq cana-rules
      (sort cana-rules
            (lambda (a b) (< (length (car b)) (length (car a))))))

(defvar cana-rules-pattern
  (concat "\\(.*?\\)\\("
          (mapconcat (lambda (s) (regexp-quote s))
                     (mapcar (lambda (rule) (car rule)) cana-rules)
                     "\\|")
          "\\)\\(.*\\)")
  "かなに変換する ASCII 文字列の正規表現.")

(defun cana-to-kana (str)
  "ASCII 文字列 STR をかなに変換した新しい文字列を返す."
  (let ((case-fold-search nil))
    (save-match-data
      (while (string-match cana-rules-pattern str)
        (setq str (concat (match-string 1 str)
                          (cadr (assoc (match-string 2 str) cana-rules))
                          (match-string 3 str))))
      str)))

(defvar cana-special-rules
  '(("ゎ" "ﾜﾟ") ("ゐ" "ｲﾟ") ("ゑ" "ｴﾟ") ("ヵ" "ｶﾟ") ("ヶ" "ｹﾟ"))
  "全角ひらがなと半角カナの便宜的な対応の連想配列.")

(defvar cana-special-rules-pattern
  (concat "\\(.*?\\)\\("
          (mapconcat (lambda (s) (regexp-quote s))
                     (mapcar (lambda (rule) (car rule)) cana-special-rules)
                     "\\|")
          "\\)\\(.*\\)")
  "半角カナに便宜的に変換するかなの正規表現.")

(defun cana-special (str)
  "STR 中の全角ひらがなを半角カナに便宜的に変換した新しい文字列を返す."
  (let ((case-fold-search nil))
    (save-match-data
      (while (string-match cana-special-rules-pattern str)
        (setq str (concat (match-string 1 str)
                          (cadr (assoc (match-string 2 str) cana-special-rules))
                          (match-string 3 str))))
      str)))

(defun cana-to-hiragana (str)
  "STR をひらがな文字列に変換した新しい文字列を返す."
  (cana-to-kana str))

(defun cana-to-katakana (str)
  "STR をカタカナ文字列に変換した新しい文字列を返す."
  (japanese-katakana (cana-to-kana str)))

(defun cana-to-zenkaku (str)
  "STR を全角英字変換した新しい文字列を返す."
  (japanese-zenkaku str))

(defun cana-to-hankaku (str)
  "STR を半角カナ変換した新しい文字列を返す."
  (japanese-hankaku (cana-special (cana-to-kana str))))

;;

;; (defun quail-cana-toggle-hankaku-zenkaku ()
;;   (interactive)
;;   (setq quail-translating nil)
;;   (let* ((start (overlay-start quail-conv-overlay))
;;          (end (overlay-end quail-conv-overlay))
;;          (ascii (buffer-substring start end))
;;          (hankaku (cana-to-hankaku quail-conversion-str))
;;          (zenkaku (cana-to-zenkaku quail-conversion-str))
;;          (str (if (not (string= hankaku ascii)) hankaku zenkaku)))
;;     ;; (setq quail-conversion-str str)
;;     (message "<%S><%S>" str quail-conversion-str)
;;     (save-excursion ;; (goto-char start)
;;                     (cana-replace-region start end str)))
;;   (setq quail-current-key nil)
;;   (setq quail-current-str nil))

;;

;; (defun quail-cana-translate (fn)
;;   (setq quail-translating nil)
;;   (let* ((start (overlay-start quail-conv-overlay))
;;          (end (overlay-end quail-conv-overlay))
;;          (ascii (buffer-substring start end))
;;          (str (apply fn (list ascii))))
;;     (save-excursion (goto-char start)
;;                     (cana-replace-region start end str))
;;     (setq quail-conversion-str str))
;;   (setq quail-current-key nil)
;;   (setq quail-current-str nil)
;;   (quail-no-conversion))

;; (defun quail-cana-hiragana ()
;;   (interactive)
;;   (quail-cana-translate #'cana-to-hiragana))

;; (defun quail-cana-katakana ()
;;   (interactive)
;;   (quail-cana-translate #'cana-to-katakana))

;; (defun quail-cana-zenkaku ()
;;   (interactive)
;;   (quail-cana-translate #'cana-to-zenkaku))

;; (defun quail-cana-hankaku ()
;;   (interactive)
;;   (quail-cana-translate #'cana-to-hankaku))

;;

(defun quail-cana-commit-hiragana ()
  "ひらがなに確定する."
  (interactive)
  (setq quail-conversion-str (cana-to-hiragana quail-conversion-str))
  (quail-no-conversion))

(defun quail-cana-commit-katakana ()
  "カタカナに確定する."
  (interactive)
  (setq quail-conversion-str (cana-to-katakana quail-conversion-str))
  (quail-no-conversion))

(defun quail-cana-commit-zenkaku ()
  "全角英字に確定する."
  (interactive)
  (setq quail-conversion-str (cana-to-zenkaku quail-conversion-str))
  (quail-no-conversion))

(defun quail-cana-commit-hankaku ()
  "半角カナに確定する."
  (interactive)
  (setq quail-conversion-str (cana-to-hankaku quail-conversion-str))
  (quail-no-conversion))

(defun quail-cana-cancel ()
  "変換をキャンセルし, 消去する."
  (interactive)
  (setq quail-conversion-str "")
  (quail-no-conversion))

;;

;; japanese-replace-region from japan-util.el.gz

(defun cana-replace-region (from to string)
  "Replace the region specified by FROM and TO to STRING."
  (goto-char from)
  (insert string)
  (delete-char (- to from)))

(defun quail-cana-hiragana-region (from to)
  "FROM から TO までのリージョンをひらがなに変換して置換する."
  (interactive "r")
  (let* ((ascii (buffer-substring from to))
         (hiragana (cana-to-hiragana ascii)))
    (cana-replace-region from to hiragana)))

(defun quail-cana-convert ()
  "CKC (Cana Kanji Converter) により漢字に変換する."
  (interactive)
  (setq quail-translating nil)
  (let* ((start (overlay-start quail-conv-overlay))
         (end (overlay-end quail-conv-overlay)))
    (setq quail-conversion-str
          (buffer-substring (overlay-start quail-conv-overlay)
                            (overlay-end quail-conv-overlay)))
    (setq quail-current-key nil)
    (setq quail-current-str nil))
  ;;
  (let* ((from (copy-marker (overlay-start quail-conv-overlay)))
         (len (- (overlay-end quail-conv-overlay) from)))
    (quail-delete-overlays)
    (setq quail-current-str nil)
    (unwind-protect
        (let ((result (ckc-region from (+ from len))))
          (move-overlay quail-conv-overlay from (point))
          (setq quail-conversion-str (buffer-substring from (point)))
          (if (= (+ from result) (point))
              (setq quail-converting nil))
          (setq quail-translating nil))
      (set-marker from nil))))

(defun quail-cana-insert-space ()
  "読みとしての空白を挿入する."
  (interactive)
  (setq quail-current-key (concat quail-current-key " "))
  (or (catch 'quail-tag
        (quail-update-translation (quail-translate-key))
        t)
      ;; If someone throws for `quail-tag' by value nil, we exit from
      ;; translation mode.
      (setq quail-translating nil)))

;; かな入力およびかな漢字変換による日本語入力メソッド
(quail-define-package
 "cana" "Japanese" "か"
 nil
 "JIS kana input on US keyboard.
"
 nil t t nil nil nil nil nil
 nil                                 ; #'quail-cana-update-translation
 '(("\C-g" . quail-cana-cancel)
   ("\C-j" . quail-cana-convert)
   ("\C-k" . quail-cana-commit-katakana)
   ("\C-l" . quail-no-conversion)
   ("\C-o" . quail-cana-commit-hankaku)
   ("\C-u" . quail-cana-commit-hiragana)
   ("\C-t" . quail-cana-commit-zenkaku)
   ;; ([escape] . quail-cana-cancel)
   (" " . nil)
   ([?\S- ] . quail-cana-insert-space))
 nil                                    ; t
 )

;; 空白を除く ASCII 文字 [!-~] キーで, その文字自身を入力
(let ((c 33))                           ; (c 32)
  (while (< c 127)
    (quail-defrule (char-to-string c) (char-to-string c))
    (setq c (1+ c))))

;; Update Quail translation region.
(defun quail-cana-update-translation (control-flag)
  (cond ((null control-flag)
         (setq quail-current-str (or quail-current-str quail-current-key)))
        ((integerp control-flag)
         (setq unread-command-events
               (append (substring quail-current-key control-flag)
                       unread-command-events)))
        (t nil))
  control-flag)

;;; ckc

(require 'url-http)
(require 'json)

(defvar ckc-partial-cancel t
  "非 nil なら, `ckc-cancel' のときに確定した文節を ASCII 文字列に戻さない.")

(defvar ckc-select-to-commit t
  "非 nil なら, 候補リストから選択したあとに確定する.")

(defun ckc-google-transliterate (string)
  "ひらがな文字列 STRING を Google Transliterate して結果をリストにして返す.

- Google 日本語入力 - CGI API デベロッパーガイド
- https://www.google.co.jp/ime/cgiapi.html"
  (let* ((coding-system 'utf-8)
         (encoded (url-hexify-string (encode-coding-string string 'utf-8)))
         (url "http://www.google.com/transliterate?langpair=ja-Hira|ja&text=")
         (url (concat url encoded))
         (url-request-method "GET")
         (url-max-redirections 0)
         (buf (url-retrieve-synchronously url))
         (p (url-http-symbol-value-in-buffer 'url-http-end-of-headers buf))
         (json (unwind-protect
                   (when p
                     (with-current-buffer buf
                       (decode-coding-string
                        (buffer-substring (1+ p) (point-max)) coding-system)))
                 (when buf (kill-buffer buf))))
         (json (if json json "[[\"\", [\"\"]]]")) ; XXX
         (vector (json-read-from-string json)))
    ;; 関数 append はベクトルを同じ要素から成るリストへ変換する便利な方法
    (append (cl-map 'vector (lambda (v) (append v nil))
                    (cl-map 'vector (lambda (v) (aref v 1)) vector))
            nil)))

;; (require 'ja-dic-utl)

(defvar ckc-input-method-title "漢"
  "String denoting CKC input method.
This string is shown at mode line when users are in CKC mode.")

;; (defvar ckc-init-file-name (locate-user-emacs-file "kkcrc" ".kkcrc")
;;   "Name of a file which contains user's initial setup code for CKC.")

;; A flag to control a file specified by `ckc-init-file-name'.
;; The value nil means the file is not yet consulted.
;; The value t means the file has already been consulted but there's
;; no need of updating it yet.
;; Any other value means that we must update the file before exiting Emacs.
;; (defvar ckc-init-file-flag nil)

;; Cash data for `ckc-lookup-key'.  This may be initialized by loading
;; a file specified by `ckc-init-file-name'.  If any elements are
;; modified, the data is written out to the file when exiting Emacs.
;; (defvar ckc-lookup-cache nil)

;; Tag symbol of `ckc-lookup-cache'.
;; (defconst ckc-lookup-cache-tag 'ckc-lookup-cache-2)

;; (defun ckc-save-init-file ()
;;   "Save initial setup code for CKC to a file specified by `ckc-init-file-name'."
;;   (if (and ckc-init-file-flag
;;            (not (eq ckc-init-file-flag t)))
;;       (let ((coding-system-for-write 'iso-2022-7bit)
;;             (print-length nil))
;;         (write-region (format "(setq ckc-lookup-cache '%S)\n" ckc-lookup-cache)
;;                       nil
;;                       ckc-init-file-name))))

;; Sequence of characters to be used for indexes for shown list.  The
;; Nth character is for the Nth conversion in the list currently shown.
(defvar ckc-show-conversion-list-index-chars
  "1234567890")

(defun ckc-help ()
  "Show key bindings available while converting by CKC."
  (interactive)
  (with-output-to-temp-buffer "*Help*"
    (princ (substitute-command-keys "\\{ckc-keymap}"))))

(defvar ckc-keymap
  (let ((map (make-sparse-keymap))
        (len (length ckc-show-conversion-list-index-chars))
        (i 0))
    (while (< i len)
      (define-key map
        (char-to-string (aref ckc-show-conversion-list-index-chars i))
        'ckc-select-from-list)
      (setq i (1+ i)))
    ;; (define-key map " " 'ckc-next)
    ;; (define-key map "\r" 'ckc-terminate)
    ;; (define-key map "\C-@" 'ckc-first-char-only)
    ;; (define-key map "\C-n" 'ckc-next)
    ;; (define-key map "\C-p" 'ckc-prev)
    ;; (define-key map "\C-i" 'ckc-shorter)
    ;; (define-key map "\C-o" 'ckc-longer)
    ;; (define-key map "I" 'ckc-shorter-conversion)
    ;; (define-key map "O" 'ckc-longer-phrase)
    ;; (define-key map "\C-c" 'ckc-cancel)
    ;; (define-key map "\C-?" 'ckc-cancel)
    ;; (define-key map "\C-f" 'ckc-next-phrase)
    ;; (define-key map "K" 'ckc-katakana)
    ;; (define-key map "H" 'ckc-hiragana)
    ;; (define-key map "l" 'ckc-show-conversion-list-or-next-group)
    ;; (define-key map "L" 'ckc-show-conversion-list-or-prev-group)
    ;; (define-key map [?\C- ] 'ckc-first-char-only)
    ;; (define-key map [delete] 'ckc-cancel)
    ;; (define-key map [return] 'ckc-terminate)
    ;; (define-key map "\C-h" 'ckc-help)
    ;;
    (define-key map "\C-@" 'ckc-first-char-only)
    (define-key map "\C-n" 'ckc-next)
    (define-key map "\C-p" 'ckc-prev)
    (define-key map "\C-c" 'ckc-cancel)
    (define-key map "\C-?" 'ckc-cancel)
    (define-key map "\C-f" 'ckc-next-phrase)
    (define-key map [?\C- ] 'ckc-first-char-only)
    (define-key map [delete] 'ckc-cancel)
    (define-key map "\C-v" 'ckc-show-conversion-list-or-next-group)
    ;; (define-key map "\M-v" 'ckc-show-conversion-list-or-prev-group)
    (define-key map "\C-b" 'ckc-show-conversion-list-or-prev-group)
    (define-key map [?\C-,] 'ckc-shorter)
    (define-key map [?\C-.] 'ckc-longer)
    (define-key map [?\C-<] 'ckc-shorter-conversion)
    (define-key map [?\C->] 'ckc-longer-phrase)
    ;; (define-key map [escape] 'ckc-cancel)
    (define-key map "\C-g" 'ckc-cancel)
    (define-key map "\C-j" 'ckc-terminate)
    (define-key map "\C-k" 'ckc-cana-katakana)
    (define-key map "\C-l" 'ckc-cana-ascii)
    (define-key map "\C-o" 'ckc-cana-hankaku)
    (define-key map "\C-u" 'ckc-cana-hiragana)
    (define-key map "\C-t" 'ckc-cana-zenkaku)
    (define-key map "\C-h" 'ckc-help)
    ;;
    map)
  "Keymap for CKC (Cana Kanji Converter).")

;;; Internal variables used in CKC.

;;
(defvar ckc-original-ascii nil
  "変換対象のもとの ASCII 文字列.")
;; /

;; The current Kana string to be converted.
(defvar ckc-original-kana nil)

;; The current key sequence (vector of Kana characters) generated from
;; `ckc-original-kana'.
(defvar ckc-current-key nil)

;; List of the current conversions for `ckc-current-key'.
(defvar ckc-current-conversions nil)

;; Vector of the same length as `ckc-current-conversion'.  The first
;; element is a vector of:
;;      o index number of the first conversion shown previously,
;;      o index number of a conversion next of the last one shown previously,
;;      o the shown string itself.
;; The remaining elements are widths (including columns for index
;; numbers) of conversions stored in the same order as in
;; `ckc-current-conversion'.
(defvar ckc-current-conversions-width nil)

(defcustom ckc-show-conversion-list-count 4
  "Count of successive `ckc-next' or `ckc-prev' to show conversion list.
When you type C-n or C-p successively this count while using the input
method `cana', the conversion candidates are shown in the echo
area while indicating the current selection by `<N>'."
  :group 'mule
  :type 'integer)

;; Count of successive invocations of `ckc-next'.
(defvar ckc-next-count nil)

;; Count of successive invocations of `ckc-prev'.
(defvar ckc-prev-count nil)

;; Provided that `ckc-current-key' is [A B C D E F G H I], the current
;; conversion target is [A B C D E F], and the sequence of which
;; conversion is found is [A B C D]:
;;
;;                                A B C D E F G H I
;; ckc-overlay-head (black):     |<--------->|
;; ckc-overlay-tail (underline):         |<------->|
;; ckc-length-head:              |<--------->|
;; ckc-length-converted:         |<----->|
;;
(defvar ckc-overlay-head nil)
(defvar ckc-overlay-tail nil)
(defvar ckc-length-head nil)
(defvar ckc-length-converted nil)
;;
(defvar ckc-length-commit nil
  "確定した文字列の長さ.")
;; /

;; Cursor type (`box' or `bar') of the current frame.
(defvar ckc-cursor-type nil)

;; Lookup Japanese dictionary to set list of conversions in
;; ckc-current-conversions for key sequence ckc-current-key of length
;; LEN.  If no conversion is found in the dictionary, don't change
;; ckc-current-conversions and return nil.
;; Postfixes are handled only if POSTFIX is non-nil.
;; (defun ckc-lookup-key (len &optional postfix prefer-noun)
;;   ;; At first, prepare cache data if any.
;;   (unless ckc-init-file-flag
;;     (setq ckc-init-file-flag t
;;           ckc-lookup-cache nil)
;;     (add-hook 'kill-emacs-hook 'ckc-save-init-file)
;;     (if (file-readable-p ckc-init-file-name)
;;         (condition-case nil
;;             (load-file ckc-init-file-name)
;;           (ckc-error "Invalid data in %s" ckc-init-file-name))))
;;   (or (and (nested-alist-p ckc-lookup-cache)
;;            (eq (car ckc-lookup-cache) ckc-lookup-cache-tag))
;;       (setq ckc-lookup-cache (list ckc-lookup-cache-tag)
;;             ckc-init-file-flag 'ckc-lookup-cache))
;;   (let ((entry (lookup-nested-alist ckc-current-key ckc-lookup-cache len 0 t)))
;;     (if (consp (car entry))
;;         (setq ckc-length-converted len
;;               ckc-current-conversions-width nil
;;               ckc-current-conversions (car entry))
;;       (setq entry (skkdic-lookup-key ckc-current-key len postfix prefer-noun))
;;       (if entry
;;           (progn
;;             (setq ckc-length-converted len
;;                   ckc-current-conversions-width nil
;;                   ckc-current-conversions (cons 1 entry))
;;             (if postfix
;;                 ;; Store this conversions in the cache.
;;                 (progn
;;                   (set-nested-alist ckc-current-key ckc-current-conversions
;;                                     ckc-lookup-cache ckc-length-converted)
;;                   (setq ckc-init-file-flag 'ckc-lookup-cache)))
;;             t)
;;         (if (= len 1)
;;             (setq ckc-length-converted 1
;;                   ckc-current-conversions-width nil
;;                   ckc-current-conversions (cons 0 nil)))))))

(defun ckc-lookup-key-sub (key len &optional postfix prefer-noun)
  "かなの配列 KEY の長さ LEN 分の変換候補のリストを返す.
POSTFIX と PREFER-NOUN は無視される."
  (let* ((string (concat key))
         (string (substring string 0 len)))
    (car (ckc-google-transliterate (concat string ",")))))

;; Lookup Japanese dictionary to set list of conversions in
;; ckc-current-conversions for key sequence ckc-current-key of length
;; LEN.  If no conversion is found in the dictionary, don't change
;; ckc-current-conversions and return nil.
;; Postfixes are handled only if POSTFIX is non-nil.
(defun ckc-lookup-key (len &optional postfix prefer-noun)
  (let ((entry nil))
    (if (consp (car entry))
        (setq ckc-length-converted len
              ckc-current-conversions-width nil
              ckc-current-conversions (car entry))
      (setq entry (ckc-lookup-key-sub ckc-current-key len postfix prefer-noun))
      (if entry
          (progn
            (setq ckc-length-converted len
                  ckc-current-conversions-width nil
                  ckc-current-conversions (cons 1 entry))
            t)
        (if (= len 1)
            (setq ckc-length-converted 1
                  ckc-current-conversions-width nil
                  ckc-current-conversions (cons 0 nil)))))))

;; /

(define-error 'ckc-error nil)
(defun ckc-error (&rest args)
  (signal 'ckc-error (apply #'format-message args)))

(defvar ckc-converting nil)

;;;###autoload
(defvar ckc-after-update-conversion-functions nil
  "Functions to run after a conversion is selected in `cana' input method.
With this input method, a user can select a proper conversion from
candidate list.  Each time he changes the selection, functions in this
list are called with two arguments; starting and ending buffer
positions that contains the current selection.")

;;;###autoload
(defun ckc-region (from to)
  "Convert Kana string in the current region to Kanji-Kana mixed string.
Users can select a desirable conversion interactively.
When called from a program, expects two arguments,
positions FROM and TO (integers or markers) specifying the target region.
When it returns, the point is at the tail of the selected conversion,
and the return value is the length of the conversion."
  (interactive "r")
  (setq ckc-original-ascii (buffer-substring from to))
  (save-excursion
    (goto-char from)
    (quail-cana-hiragana-region from to)
    (setq to (point)))
  (setq ckc-original-kana (buffer-substring from to))
  (goto-char from)

  ;; Setup overlays.
  (if (overlayp ckc-overlay-head)
      (move-overlay ckc-overlay-head from to)
    (setq ckc-overlay-head (make-overlay from to nil nil t))
    (overlay-put ckc-overlay-head 'face 'highlight))
  (if (overlayp ckc-overlay-tail)
      (move-overlay ckc-overlay-tail to to)
    (setq ckc-overlay-tail (make-overlay to to nil nil t))
    (overlay-put ckc-overlay-tail 'face 'underline))

  (setq ckc-current-key (string-to-vector ckc-original-kana))
  (setq ckc-length-head (length ckc-current-key))
  (setq ckc-length-converted 0)
  ;;
  (setq ckc-length-commit 0)
  ;; /

  (unwind-protect
      ;; At first convert the region to the first candidate.
      (let ((current-input-method-title ckc-input-method-title)
            (input-method-function nil)
            (modified-p (buffer-modified-p))
            (first t))
        (while (not (ckc-lookup-key ckc-length-head nil first))
          (setq ckc-length-head (1- ckc-length-head)
                first nil))
        (goto-char to)
        (ckc-update-conversion 'all)
        (setq ckc-next-count 1 ckc-prev-count 0)
        (if (and (>= ckc-next-count ckc-show-conversion-list-count)
                 (>= (length ckc-current-conversions) 3))
            (ckc-show-conversion-list-or-next-group))

        ;; Then, ask users to select a desirable conversion.
        (force-mode-line-update)
        (setq ckc-converting t)
        ;; Hide "... loaded" message.
        (message nil)
        (while ckc-converting
          (set-buffer-modified-p modified-p)
          (let* ((overriding-terminal-local-map ckc-keymap)
                 (help-char nil)
                 (keyseq (read-key-sequence nil))
                 (cmd (lookup-key ckc-keymap keyseq)))
            (if (commandp cmd)
                (condition-case err
                    (progn
                      (cond ((eq cmd 'ckc-next)
                             (setq ckc-next-count (1+ ckc-next-count)
                                   ckc-prev-count 0))
                            ((eq cmd 'ckc-prev)
                             (setq ckc-prev-count (1+ ckc-prev-count)
                                   ckc-next-count 0))
                            (t
                             (setq ckc-next-count 0 ckc-prev-count 0)))
                      (call-interactively cmd))
                  (ckc-error (message "%s" (cdr err)) (beep)))
              ;; KEYSEQ is not defined in CKC keymap.
              ;; Let's put the event back.
              (setq unread-input-method-events
                    (append (string-to-list (this-single-command-raw-keys))
                            unread-input-method-events))
              (ckc-terminate))))

        (force-mode-line-update)
        (goto-char (overlay-end ckc-overlay-tail))
        (- (overlay-start ckc-overlay-head) from))
    (delete-overlay ckc-overlay-head)
    (delete-overlay ckc-overlay-tail)))

(defun ckc-terminate ()
  "Exit from CKC mode by fixing the current conversion."
  (interactive)
  (goto-char (overlay-end ckc-overlay-tail))
  (move-overlay ckc-overlay-head (point) (point))
  (setq ckc-converting nil))

(defun ckc-cancel ()
  "Exit from CKC mode by canceling any conversions."
  (interactive)
  (goto-char (overlay-start ckc-overlay-head))
  (delete-region (overlay-start ckc-overlay-head)
                 (overlay-end ckc-overlay-tail))
  ;; (insert ckc-original-kana)
  ;; XXX
  (if ckc-partial-cancel
      (insert (ckc-cana-to-ascii))
    (delete-region (- (point) ckc-length-commit) (point))
    (insert ckc-original-ascii))
  ;; /
  (setq ckc-converting nil))

(defun ckc-first-char-only ()
  "Select only the first character currently converted."
  (interactive)
  (goto-char (overlay-start ckc-overlay-head))
  (forward-char 1)
  (delete-region (point) (overlay-end ckc-overlay-tail))
  (ckc-terminate))

;; (defun ckc-next ()
;;   "Select the next candidate of conversion."
;;   (interactive)
;;   (let ((idx (1+ (car ckc-current-conversions))))
;;     (if (< idx 0)
;;         (setq idx 1))
;;     (if (>= idx (length ckc-current-conversions))
;;         (setq idx 0))
;;     (setcar ckc-current-conversions idx)
;;     (if (> idx 1)
;;         (progn
;;           (set-nested-alist ckc-current-key ckc-current-conversions
;;                             ckc-lookup-cache ckc-length-converted)
;;           (setq ckc-init-file-flag 'ckc-lookup-cache)))
;;     (if (or ckc-current-conversions-width
;;             (>= ckc-next-count ckc-show-conversion-list-count))
;;         (ckc-show-conversion-list-update))
;;     (ckc-update-conversion)))

(defun ckc-next ()
  "Select the next candidate of conversion."
  (interactive)
  (let ((idx (1+ (car ckc-current-conversions))))
    (if (< idx 0)
        (setq idx 1))
    (if (>= idx (length ckc-current-conversions))
        (setq idx 0))
    (setcar ckc-current-conversions idx)
    (if (or ckc-current-conversions-width
            (>= ckc-next-count ckc-show-conversion-list-count))
        (ckc-show-conversion-list-update))
    (ckc-update-conversion)))

;; (defun ckc-prev ()
;;   "Select the previous candidate of conversion."
;;   (interactive)
;;   (let ((idx (1- (car ckc-current-conversions))))
;;     (if (< idx 0)
;;         (setq idx (1- (length ckc-current-conversions))))
;;     (setcar ckc-current-conversions idx)
;;     (if (> idx 1)
;;         (progn
;;           (set-nested-alist ckc-current-key ckc-current-conversions
;;                             ckc-lookup-cache ckc-length-converted)
;;           (setq ckc-init-file-flag 'ckc-lookup-cache)))
;;     (if (or ckc-current-conversions-width
;;             (>= ckc-prev-count ckc-show-conversion-list-count))
;;         (ckc-show-conversion-list-update))
;;     (ckc-update-conversion)))

(defun ckc-prev ()
  "Select the previous candidate of conversion."
  (interactive)
  (let ((idx (1- (car ckc-current-conversions))))
    (if (< idx 0)
        (setq idx (1- (length ckc-current-conversions))))
    (setcar ckc-current-conversions idx)
    (if (or ckc-current-conversions-width
            (>= ckc-prev-count ckc-show-conversion-list-count))
        (ckc-show-conversion-list-update))
    (ckc-update-conversion)))

;; /

(defun ckc-select-from-list ()
  "Select one candidate from the list currently shown in echo area."
  (interactive)
  (let (idx)
    (if ckc-current-conversions-width
        (let ((len (length ckc-show-conversion-list-index-chars))
              (maxlen (- (aref (aref ckc-current-conversions-width 0) 1)
                         (aref (aref ckc-current-conversions-width 0) 0)))
              (i 0))
          (if (> len maxlen)
              (setq len maxlen))
          (while (< i len)
            (if (= (aref ckc-show-conversion-list-index-chars i)
                   last-input-event)
                (setq idx i i len)
              (setq i (1+ i))))))
    (if idx
        (progn
          (setcar ckc-current-conversions
                  (+ (aref (aref ckc-current-conversions-width 0) 0) idx))
          (ckc-show-conversion-list-update)
          ;; (ckc-update-conversion))
          (ckc-update-conversion)
          (when ckc-select-to-commit
            (ckc-next-phrase)
            ;; Hide list.
            (message nil)))
      ;; /
      (setq unread-input-method-events
            (cons last-input-event unread-input-method-events))
      (ckc-terminate))))

(defun ckc-katakana ()
  "Convert to Katakana."
  (interactive)
  (setcar ckc-current-conversions -1)
  (ckc-update-conversion 'all))

(defun ckc-hiragana ()
  "Convert to hiragana."
  (interactive)
  (setcar ckc-current-conversions 0)
  (ckc-update-conversion))

(defun ckc-shorter ()
  "Make the Kana string to be converted shorter."
  (interactive)
  (if (<= ckc-length-head 1)
      (ckc-error "Can't be shorter"))
  (setq ckc-length-head (1- ckc-length-head))
  (if (> ckc-length-converted ckc-length-head)
      (let ((len ckc-length-head))
        (setq ckc-length-converted 0)
        (while (not (ckc-lookup-key len))
          (setq len (1- len)))))
  (ckc-update-conversion 'all))

(defun ckc-longer ()
  "Make the Kana string to be converted longer."
  (interactive)
  (if (>= ckc-length-head (length ckc-current-key))
      (ckc-error "Can't be longer"))
  (setq ckc-length-head (1+ ckc-length-head))
  ;; This time, try also entries with postfixes.
  (ckc-lookup-key ckc-length-head 'postfix)
  (ckc-update-conversion 'all))

(defun ckc-shorter-conversion ()
  "Make the Kana string to be converted shorter."
  (interactive)
  (if (<= ckc-length-converted 1)
      (ckc-error "Can't be shorter"))
  (let ((len (1- ckc-length-converted)))
    (setq ckc-length-converted 0)
    (while (not (ckc-lookup-key len))
      (setq len (1- len))))
  (ckc-update-conversion 'all))

(defun ckc-longer-phrase ()
  "Make the current phrase (BUNSETSU) longer without looking up dictionary."
  (interactive)
  (if (>= ckc-length-head (length ckc-current-key))
      (ckc-error "Can't be longer"))
  (setq ckc-length-head (1+ ckc-length-head))
  (ckc-update-conversion 'all))

(defun ckc-next-phrase ()
  "Fix the currently converted string and try to convert the remaining string."
  (interactive)
  (if (>= ckc-length-head (length ckc-current-key))
      (ckc-terminate)
    (setq ckc-length-head (- (length ckc-current-key) ckc-length-head))
    (goto-char (overlay-end ckc-overlay-head))
    (while (and (< (point) (overlay-end ckc-overlay-tail))
                (looking-at "\\CH"))
      (goto-char (match-end 0))
      (setq ckc-length-head (1- ckc-length-head)))
    (if (= ckc-length-head 0)
        (ckc-terminate)
      (let ((newkey (make-vector ckc-length-head 0))
            (idx (- (length ckc-current-key) ckc-length-head))
            (len ckc-length-head)
            (i 0))
        ;; For the moment, (setq ckc-original-kana (concat newkey))
        ;; doesn't work.
        (setq ckc-original-kana "")
        (while (< i ckc-length-head)
          (aset newkey i (aref ckc-current-key (+ idx i)))
          (setq ckc-original-kana
                (concat ckc-original-kana (char-to-string (aref newkey i))))
          (setq i (1+ i)))
        ;;
        (cl-incf ckc-length-commit
                 (- (length ckc-current-key) (length newkey)))
        ;; /
        (setq ckc-current-key newkey)
        (setq ckc-length-converted 0)
        (while (and (not (ckc-lookup-key ckc-length-head nil
                                         (< ckc-length-head len)))
                    (> ckc-length-head 1))
          (setq ckc-length-head (1- ckc-length-head)))
        (let ((pos (point))
              (tail (overlay-end ckc-overlay-tail)))
          (move-overlay ckc-overlay-head pos tail)
          (move-overlay ckc-overlay-tail tail tail))
        (ckc-update-conversion 'all)))))

;; We'll show users a list of available conversions in echo area with
;; index numbers so that users can select one conversion with the
;; number.

;; Set `ckc-current-conversions-width'.
(defun ckc-setup-current-conversions-width ()
  (let ((convs (cdr ckc-current-conversions))
        (len (length ckc-current-conversions))
        (idx 1))
    (setq ckc-current-conversions-width (make-vector len nil))
    ;; To tell `ckc-show-conversion-list-update' to generate
    ;; message from scratch.
    (aset ckc-current-conversions-width 0 (vector len -2 nil))
    ;; Fill the remaining slots.
    (while convs
      (aset ckc-current-conversions-width idx
            (+ (string-width (car convs)) 4))
      (setq convs (cdr convs)
            idx (1+ idx)))))

(defun ckc-show-conversion-list-or-next-group ()
  "Show list of available conversions in echo area with index numbers.
If the list is already shown, show the next group of conversions,
and change the current conversion to the first one in the group."
  (interactive)
  (if (< (length ckc-current-conversions) 3)
      (ckc-error "No alternative"))
  (if ckc-current-conversions-width
      (let ((next-idx (aref (aref ckc-current-conversions-width 0) 1)))
        (if (< next-idx (length ckc-current-conversions-width))
            (setcar ckc-current-conversions next-idx)
          (setcar ckc-current-conversions 1))
        (ckc-show-conversion-list-update)
        (ckc-update-conversion))
    (ckc-setup-current-conversions-width)
    (ckc-show-conversion-list-update)))

(defun ckc-show-conversion-list-or-prev-group ()
  "Show list of available conversions in echo area with index numbers.
If the list is already shown, show the previous group of conversions,
and change the current conversion to the last one in the group."
  (interactive)
  (if (< (length ckc-current-conversions) 3)
      (ckc-error "No alternative"))
  (if ckc-current-conversions-width
      (let ((this-idx (aref (aref ckc-current-conversions-width 0) 0)))
        (if (> this-idx 1)
            (setcar ckc-current-conversions (1- this-idx))
          (setcar ckc-current-conversions
                  (1- (length ckc-current-conversions-width))))
        (ckc-show-conversion-list-update)
        (ckc-update-conversion))
    (ckc-setup-current-conversions-width)
    (ckc-show-conversion-list-update)))

;; Update the conversion list shown in echo area.
(defun ckc-show-conversion-list-update ()
  (or ckc-current-conversions-width
      (ckc-setup-current-conversions-width))
  (let* ((current-idx (car ckc-current-conversions))
         (first-slot (aref ckc-current-conversions-width 0))
         (this-idx (aref first-slot 0))
         (next-idx (aref first-slot 1))
         (msg (aref first-slot 2)))
    (if (< current-idx this-idx)
        ;; The currently selected conversion is before the list shown
        ;; previously.  We must start calculation of message width
        ;; from the start again.
        (setq this-idx 1 msg nil)
      (if (>= current-idx next-idx)
          ;; The currently selected conversion is after the list shown
          ;; previously.  We start calculation of message width from
          ;; the conversion next of TO.
          (setq this-idx next-idx msg nil)))
    (if (not msg)
        (let ((len (length ckc-current-conversions))
              (max-width (window-width (minibuffer-window)))
              (width-table ckc-current-conversions-width)
              (width 0)
              (idx this-idx)
              (max-items (length ckc-show-conversion-list-index-chars))
              l)
          ;; Set THIS-IDX to the first index of conversion to be shown
          ;; in MSG, and reflect it in ckc-current-conversions-width.
          (while (<= idx current-idx)
            (if (and (<= (+ width (aref width-table idx)) max-width)
                     (< (- idx this-idx) max-items))
                (setq width (+ width (aref width-table idx)))
              (setq this-idx idx width (aref width-table idx)))
            (setq idx (1+ idx)
                  l (cdr l)))
          (aset first-slot 0 this-idx)
          ;; Set NEXT-IDX to the next index of the last conversion
          ;; shown in MSG, and reflect it in
          ;; ckc-current-conversions-width.
          (while (and (< idx len)
                      (<= (+ width (aref width-table idx)) max-width)
                      (< (- idx this-idx) max-items))
            (setq width (+ width (aref width-table idx))
                  idx (1+ idx)
                  l (cdr l)))
          (aset first-slot 1 (setq next-idx idx))
          (setq l (nthcdr this-idx ckc-current-conversions))
          (setq msg (format " %c %s"
                            (aref ckc-show-conversion-list-index-chars 0)
                            (propertize (car l)
                                        'ckc-conversion-index this-idx))
                idx (1+ this-idx)
                l (cdr l))
          (while (< idx next-idx)
            (setq msg (format "%s  %c %s"
                              msg
                              (aref ckc-show-conversion-list-index-chars
                                    (- idx this-idx))
                              (propertize (car l)
                                          'ckc-conversion-index idx))
                  idx (1+ idx)
                  l (cdr l)))
          (aset first-slot 2 msg)))

    ;; Highlight the current conversion.
    (if (> current-idx 0)
        (let ((pos 3)
              (limit (length msg)))
          (remove-text-properties 0 (length msg) '(face nil) msg)
          (while (not (eq (get-text-property pos 'ckc-conversion-index msg)
                          current-idx))
            (setq pos (next-single-property-change pos 'ckc-conversion-index
                                                   msg limit)))
          (put-text-property pos (next-single-property-change
                                  pos 'ckc-conversion-index msg limit)
                             'face 'highlight msg)))
    (let ((message-log-max nil))
      (message "%s" msg))))

;; Update the conversion area with the latest conversion selected.
;; ALL if non-nil means to update the whole area, else update only
;; inside quail-overlay-head.

(defun ckc-update-conversion (&optional all)
  (goto-char (overlay-start ckc-overlay-head))
  (cond ((= (car ckc-current-conversions) 0) ; Hiragana
         (let ((i 0))
           (while (< i ckc-length-converted)
             (insert (aref ckc-current-key i))
             (setq i (1+ i)))))
        ((= (car ckc-current-conversions) -1) ; Katakana
         (let ((i 0))
           (while (< i ckc-length-converted)
             (insert (japanese-katakana (aref ckc-current-key i)))
             (setq i (1+ i)))))
        (t
         (insert (nth (car ckc-current-conversions) ckc-current-conversions))))
  (delete-region (point) (overlay-start ckc-overlay-tail))
  (if all
      (let ((len (length ckc-current-key))
            (i ckc-length-converted))
        (delete-region (overlay-start ckc-overlay-tail)
                       (overlay-end ckc-overlay-head))
        (while (< i ckc-length-head)
          (if (= (car ckc-current-conversions) -1)
              (insert (japanese-katakana (aref ckc-current-key i)))
            (insert (aref ckc-current-key i)))
          (setq i (1+ i)))
        (let ((pos (point)))
          (while (< i len)
            (insert (aref ckc-current-key i))
            (setq i (1+ i)))
          (move-overlay ckc-overlay-head
                        (overlay-start ckc-overlay-head) pos)
          (delete-region (point) (overlay-end ckc-overlay-tail)))))
  (unwind-protect
      (run-hook-with-args 'ckc-after-update-conversion-functions
                          (overlay-start ckc-overlay-head)
                          (overlay-end ckc-overlay-head))
    (goto-char (overlay-end ckc-overlay-tail))))

;;

(defun ckc-cana-hiragana ()
  "ひらがなに確定する."
  (interactive)
  (ckc-hiragana)
  (ckc-next-phrase))

(defun ckc-cana-katakana ()
  "カタカナに確定する."
  (interactive)
  (ckc-katakana)
  (ckc-next-phrase))

;; hankaku/zenkaku

(defun ckc-cana-to-hankaku ()
  "半角カナに変換する."
  (interactive)
  (mapconcat
   #'(lambda (c) (japanese-hankaku (cana-special (char-to-string c))))
   (string-to-list
    (substring (mapconcat #'(lambda (c) (char-to-string c)) ckc-current-key "")
               0 ckc-length-head))
   ""))

(defun ckc-cana-to-zenkaku ()
  "全角英字に変換する."
  (interactive)
  (mapconcat
   #'(lambda (c)
       (japanese-zenkaku
        (or (car (cl-rassoc (list (char-to-string c)) cana-rules :test #'equal))
            (char-to-string c))))
   (string-to-list
    (substring (mapconcat #'(lambda (c) (char-to-string c)) ckc-current-key "")
               0 ckc-length-head))
   ""))

(defun ckc-cana-hankaku ()
  "半角カナに確定する."
  (interactive)
  (goto-char (overlay-start ckc-overlay-head))
  (insert (ckc-cana-to-hankaku))
  (delete-region (point) (overlay-end ckc-overlay-head))
  (unwind-protect
      (run-hook-with-args 'ckc-after-update-conversion-functions
                          (overlay-start ckc-overlay-head)
                          (overlay-end ckc-overlay-head))
    (goto-char (overlay-end ckc-overlay-tail))
    (ckc-next-phrase)))

(defun ckc-cana-zenkaku ()
  "全角英字に確定する."
  (interactive)
  (goto-char (overlay-start ckc-overlay-head))
  (insert (ckc-cana-to-zenkaku))
  (delete-region (point) (overlay-end ckc-overlay-head))
  (unwind-protect
      (run-hook-with-args 'ckc-after-update-conversion-functions
                          (overlay-start ckc-overlay-head)
                          (overlay-end ckc-overlay-head))
    (goto-char (overlay-end ckc-overlay-tail))
    (ckc-next-phrase)))

;; ascii

(defun ckc-cana-to-ascii (&optional current-key length-head)
  "ASCII 文字列に変換する."
  (interactive)
  (let* ((ckc-current-key (if current-key current-key ckc-current-key))
         (ckc-length-head (if length-head length-head ckc-length-head)))
    (mapconcat
     #'(lambda (c)
         (or (car (cl-rassoc (list (char-to-string c))
                             cana-rules :test #'equal))
             (char-to-string c)))
     (string-to-list
      (substring (mapconcat #'(lambda (c) (char-to-string c))
                            ckc-current-key "")
                 0 ckc-length-head))
     "")))

(defun ckc-cana-ascii ()
  "ASCII 文字列に確定する."
  (interactive)
  (goto-char (overlay-start ckc-overlay-head))
  (insert (ckc-cana-to-ascii))
  (delete-region (point) (overlay-end ckc-overlay-head))
  (unwind-protect
      (run-hook-with-args 'ckc-after-update-conversion-functions
                          (overlay-start ckc-overlay-head)
                          (overlay-end ckc-overlay-head))
    (goto-char (overlay-end ckc-overlay-tail))
    (ckc-next-phrase)))

;;; reconvert

(defvar cana-backward-scan-pattern
  (concat "\\("
          (mapconcat (lambda (s) (regexp-quote s))
                     (mapcar (lambda (rule) (car rule)) cana-rules)
                     "\\|")
          "\\)+$")
  "再変換の対象となる部分文字列にマッチする正規表現.")

(defun cana-backward-scan-ascii (str)
  "STR を末尾から先頭方向にスキャンして, 再変換の対象となる部分文字列を返す
(`cana-backward-scan-pattern' を参照).
変換すべき文字列がないときは, nil を返す."
  (let ((case-fold-search nil))
    (save-match-data
      (if (string-match cana-backward-scan-pattern str)
          (match-string-no-properties 0 str)
        nil))))

(defun cana-reconvert ()
  "バッファ内の文字列に対して `ckc-region' を使って再変換を行う.
リージョンがアクティブのときは, そのリージョンを変換する.
そうでなければ, カーソルの左の対象文字列を変換する
(`cana-backward-scan-ascii' を参照)."
  (interactive)
  (if (use-region-p)
      (ckc-region (region-beginning) (region-end))
    (let* ((str (buffer-substring (point-at-bol) (point)))
           (ascii (cana-backward-scan-ascii str)))
      (when ascii
        (ckc-region (- (point) (length ascii)) (point))))))

;;; cana preview

;; 空白を除く ASCII 文字 [!-~] キーに, quail-self-insert-command を割り当てる
;; (let ((c 33))
;;   (while (< c 127)
;;     ;; (quail-defrule (char-to-string c) (char-to-string c))
;;     (define-key (quail-conversion-keymap)
;;       (char-to-string c) 'quail-self-insert-command)
;;     (setq c (1+ c))))

;;

(defvar cana-preview-enabled t "非 nil なら, かなプレビューを有効化する.")

;; (defvar cana-preview-enabled nil
;;   "`echo-area' なら, echo area にかなプレビューを表示する.
;; `popup-tip' なら, popup tip でかなプレビューを表示する.
;; nil なら, かなプレビューを無効化する.")

;; (defface cana-preview-face
;;   '((t (:inherit popup-tip-face
;;                  :weight normal :slant normal
;;                  :underline nil :inverse-video nil)))
;;   "かなプレビューのポップアップのフェイス.")

;; (defvar cana-preview-popup nil "ポップアップオブジェクト.")

;; (defun cana-preview-hide ()
;;   "かなプレビューを非表示にする."
;;   ;;
;;   ;; (when (and (featurep 'popup)
;;   (when (and (eq cana-preview-enabled 'popup-tip)
;;              (featurep 'popup)
;;              ;; /
;;              (popup-live-p cana-preview-popup))
;;     (popup-delete cana-preview-popup)))

;; (defun cana-preview-show (&rest _arguments)
;;   "`cana-preview-enabled' が非 nil なら, かなプレビューを表示する."
;;   (when (equal current-input-method "cana")
;;     (let* ((beg (overlay-start quail-conv-overlay))
;;            (end (overlay-end quail-conv-overlay))
;;            (str (and beg end (buffer-substring beg end))))
;;       (cana-preview-hide)
;;       (when str
;;         (setq quail-conversion-str str)
;;         (setq quail-current-str nil
;;               quail-current-key nil)
;;         ;;
;;         (when (eq cana-preview-enabled 'echo-area)
;;           (let ((message-log-max nil))
;;             (message "%s" (cana-to-kana str))))
;;         ;; (when (and (featurep 'popup)
;;         (when (and (eq cana-preview-enabled 'popup-tip)
;;                    (featurep 'popup)
;;                    ;; /
;;                    cana-preview-enabled)
;;           (cana-preview-hide)
;;           (setq cana-preview-popup (popup-tip (cana-to-kana str)
;;                                               :face 'cana-preview-face
;;                                               :height 1 :nowait t)))))))

(defun cana-preview-show (&rest _arguments)
  "`cana-preview-enabled' が非 nil なら, かなプレビューを表示する."
  (when (equal current-input-method "cana")
    (let* ((beg (overlay-start quail-conv-overlay))
           (end (overlay-end quail-conv-overlay))
           (str (and beg end (buffer-substring beg end))))
      (when str
        (setq quail-conversion-str str)
        (setq quail-current-str nil
              quail-current-key nil)
        (when cana-preview-enabled
          (let ((message-log-max nil))
            (message "%s" (cana-to-kana str))))))))

;;

;; かなプレビューを表示・非表示するアドバイスとフック
;; (dolist (fun '(quail-conversion-backward-delete-char
;;                quail-conversion-delete-char
;;                quail-self-insert-command
;;                quail-cana-convert))
;;   (advice-add fun :after #'cana-preview-show))

;; (advice-add 'quail-cana-cancel :after #'cana-preview-hide)
;; (advice-add 'quail-cana-convert :before #'cana-preview-hide)

;; (add-hook 'post-command-hook #'cana-preview-hide)

(advice-add 'quail-show-guidance :after #'cana-preview-show)

;;

(defun cana-preview-toggle ()
  "かなプレビューをトグルする."
  (interactive)
  (setq cana-preview-enabled (not cana-preview-enabled))
  (message "Kana preview %s" (if cana-preview-enabled "on" "off"))
  (cana-preview-show))

;;; cursor color

(defvar cana-cursor-color nil
  "cana モードのときのカーソル色を表す文字列.
nil なら, カーソル色を変更しない.")

(defvar cana-cursor-color-default
  (cdr (assq 'cursor-color (frame-parameters (selected-frame))))
  "cana モードでないときのカーソル色を表す文字列.")

(defun cana-cursor-color-set-color ()
  "cana モードのときにカーソル色を `cana-cursor-color' に変更する."
  (cond ((null cana-cursor-color) nil)
        ((and cana-cursor-color (equal current-input-method "cana"))
         (set-cursor-color cana-cursor-color))
        (t (set-cursor-color cana-cursor-color-default))))

(add-hook 'post-command-hook 'cana-cursor-color-set-color)

;; provide

(provide 'cana)
;;; cana.el ends here
