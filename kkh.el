;;; kkh.el --- Kana Kanji Henkan                     -*- lexical-binding: t; -*-

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

;; (when (require 'kkh nil t)
;;   (setq default-input-method "japanese-kkh")
;;   ;; USかな配列 (default)
;;   ;; (setq kkh-default-layout-name "uskana")
;;   ;; ローマ字入力
;;   ;; (setq kkh-default-layout-name "roman")
;;   ;; カーソル色を Teal 400 に
;;   ;; (setq kkh-cursor-color "#26A69A")
;;   ;; (add-hook 'post-command-hook 'kkh-cursor-color-set-color)
;;   ;; C-変換 で再変換
;;   ;; (define-key global-map (kbd "C-<henkan>") 'kkh-reconvert)
;;   ;; C-無変換 でかなプレビューをトグル
;;   ;; (define-key (quail-conversion-keymap) (kbd "C-<muhenkan>") 'kkh-preview-toggle)
;;   ;; S-無変換 で再入力
;;   ;; (define-key global-map (kbd "S-<muhenkan>") 'kkh-reinput)
;;   ;; M-無変換 で全バッファでインプットメソッドを OFF
;;   ;; (define-key global-map (kbd "M-<muhenkan>") 'kkh-deactivate-input-method-all-buffers)
;;   ;; (define-key minibuffer-mode-map (kbd "M-<muhenkan>") 'kkh-deactivate-input-method-all-buffers)
;;   ;; C-全角/半角 でかな入力配列を選択
;;   ;; (define-key global-map (kbd "C-<zenkaku-hankaku>") 'kkh-select-layout)
;;   )

;;; Code:

;;; kkh-layouts

(require 'quail)

(defvar kkh-layouts nil "かな入力配列の連想配列.")

(defun kkh-define-layout (layout)
  "かな入力配列 LAYOUT を定義する.
LAYOUT は (NAME TITLE DOCSTRING RULES) の形式のリスト.
すでに NAME という名前のかな入力配列が定義されていれば, 上書きする."
  (let* ((name (car layout))
         (old-layout (assoc name kkh-layouts)))
    (if old-layout
        (setcdr old-layout (cdr layout))
      (add-to-list 'kkh-layouts layout t))))

;;; uskana

(kkh-define-layout
 '("uskana"
   "USかな"
   "USかな配列"

   (( "3" "あ") ( "e" "い") ( "4" "う") ( "5" "え") ( "6" "お")
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
    ("~/" "／") ("~?" "∞"))))          ; 全角スラッシュ

;;; roman

;; based on leim/quail/japanese.el.gz
;; (not supporting `quail-japanese-use-double-n')
(kkh-define-layout
 '("roman"
   "Roman"
   "ローマ字入力"

   (( "a" "あ") ( "i" "い") ( "u" "う") ( "e" "え") ( "o" "お")
    ("ka" "か") ("ki" "き") ("ku" "く") ("ke" "け") ("ko" "こ")
    ("sa" "さ") ("si" "し") ("su" "す") ("se" "せ") ("so" "そ")
    ("ta" "た") ("ti" "ち") ("tu" "つ") ("te" "て") ("to" "と")
    ("na" "な") ("ni" "に") ("nu" "ぬ") ("ne" "ね") ("no" "の")
    ("ha" "は") ("hi" "ひ") ("hu" "ふ") ("he" "へ") ("ho" "ほ")
    ("ma" "ま") ("mi" "み") ("mu" "む") ("me" "め") ("mo" "も")
    ("ya" "や")             ("yu" "ゆ")             ("yo" "よ")
    ("ra" "ら") ("ri" "り") ("ru" "る") ("re" "れ") ("ro" "ろ")
    ("la" "ら") ("li" "り") ("lu" "る") ("le" "れ") ("lo" "ろ")
    ("wa" "わ") ("wi" "ゐ") ("wu" "う") ("we" "ゑ") ("wo" "を")
    ("n'" "ん")
    ("ga" "が") ("gi" "ぎ") ("gu" "ぐ") ("ge" "げ") ("go" "ご")
    ("za" "ざ") ("zi" "じ") ("zu" "ず") ("ze" "ぜ") ("zo" "ぞ")
    ("da" "だ") ("di" "ぢ") ("du" "づ") ("de" "で") ("do" "ど")
    ("ba" "ば") ("bi" "び") ("bu" "ぶ") ("be" "べ") ("bo" "ぼ")
    ("pa" "ぱ") ("pi" "ぴ") ("pu" "ぷ") ("pe" "ぺ") ("po" "ぽ")

    ("kya" "きゃ") ("kyu" "きゅ") ("kye" "きぇ") ("kyo" "きょ")
    ("sya" "しゃ") ("syu" "しゅ") ("sye" "しぇ") ("syo" "しょ")
    ("sha" "しゃ") ("shu" "しゅ") ("she" "しぇ") ("sho" "しょ")
    ("cha" "ちゃ") ("chu" "ちゅ") ("che" "ちぇ") ("cho" "ちょ")
    ("tya" "ちゃ") ("tyu" "ちゅ") ("tye" "ちぇ") ("tyo" "ちょ")
    ("nya" "にゃ") ("nyu" "にゅ") ("nye" "にぇ") ("nyo" "にょ")
    ("hya" "ひゃ") ("hyu" "ひゅ") ("hye" "ひぇ") ("hyo" "ひょ")
    ("mya" "みゃ") ("myu" "みゅ") ("mye" "みぇ") ("myo" "みょ")
    ("rya" "りゃ") ("ryu" "りゅ") ("rye" "りぇ") ("ryo" "りょ")
    ("lya" "りゃ") ("lyu" "りゅ") ("lye" "りぇ") ("lyo" "りょ")
    ("gya" "ぎゃ") ("gyu" "ぎゅ") ("gye" "ぎぇ") ("gyo" "ぎょ")
    ("zya" "じゃ") ("zyu" "じゅ") ("zye" "じぇ") ("zyo" "じょ")
    ("jya" "じゃ") ("jyu" "じゅ") ("jye" "じぇ") ("jyo" "じょ")
    ( "ja" "じゃ") ( "ju" "じゅ") ( "je" "じぇ") ( "jo" "じょ")
    ("bya" "びゃ") ("byu" "びゅ") ("bye" "びぇ") ("byo" "びょ")
    ("pya" "ぴゃ") ("pyu" "ぴゅ") ("pye" "ぴぇ") ("pyo" "ぴょ")

    ("kwa" "くゎ") ("kwi" "くぃ") ("kwe" "くぇ") ("kwo" "くぉ")
    ("tsa" "つぁ") ("tsi" "つぃ") ("tse" "つぇ") ("tso" "つぉ")
    ( "fa" "ふぁ") ( "fi" "ふぃ") ( "fe" "ふぇ") ( "fo" "ふぉ")
    ("gwa" "ぐゎ") ("gwi" "ぐぃ") ("gwe" "ぐぇ") ("gwo" "ぐぉ")

    ("dyi" "でぃ") ("dyu" "どぅ") ("dye" "でぇ") ("dyo" "どぉ")
    ("xwi" "うぃ")                ("xwe" "うぇ") ("xwo" "うぉ")

    ("shi" "し") ("tyi" "てぃ") ("chi" "ち") ("tsu" "つ") ("ji" "じ")
    ("fu"  "ふ")
    ("ye" "いぇ")

    ("va" "ヴぁ") ("vi" "ヴぃ") ("vu" "ヴ") ("ve" "ヴぇ") ("vo" "ヴぉ")

    ("xa"  "ぁ") ("xi"  "ぃ") ("xu"  "ぅ") ("xe"  "ぇ") ("xo"  "ぉ")
    ("xtu" "っ") ("xya" "ゃ") ("xyu" "ゅ") ("xyo" "ょ") ("xwa" "ゎ")
    ("xka" "ヵ") ("xke" "ヶ")

    ;; ("1" "１") ("2" "２") ("3" "３") ("4" "４") ("5" "５")
    ;; ("6" "６") ("7" "７") ("8" "８") ("9" "９") ("0" "０")

    ;; ("!" "！") ("@" "＠") ("#" "＃") ("$" "＄") ("%" "％")
    ;; ("^" "＾") ("&" "＆") ("*" "＊") ("(" "（") (")" "）")
    ;; ("-" "ー") ("=" "＝") ("`" "｀") ("\\" "￥") ("|" "｜")
    ;; ("_" "＿") ("+" "＋") ("~" "￣") ("[" "「") ("]" "」")
    ;; ("{" "｛") ("}" "｝") (":" "：") (";" "；") ("\""  "”")
    ;; ("'" "’") ("." "。") ("," "、") ("<" "＜") (">" "＞")
    ;; ("?" "？") ("/" "／")

    ("n" "ん")
    ("bb" "っb") ("cc" "っc") ("dd" "っd") ("ff" "っf") ("gg" "っg")
    ("hh" "っh") ("jj" "っj") ("kk" "っk") ("ll" "っl") ("mm" "っm")
    ("pp" "っp") ("qq" "っq") ("rr" "っr") ("ss" "っs") ("tt" "っt")
    ("vv" "っv") ("ww" "っw") ("xx" "っx") ("yy" "っy") ("zz" "っz")

    ("-" "ー") ("[" "「") ("]" "」") ("." "。") ("," "、")

    ("z1" "○") ("z!" "●")
    ("z2" "▽") ("z@" "▼")
    ("z3" "△") ("z#" "▲")
    ("z4" "□") ("z$" "■")
    ("z5" "◇") ("z%" "◆")
    ("z6" "☆") ("z^" "★")
    ("z7" "◎") ("z&" "£")
    ("z8" "¢") ("z*" "×")
    ("z9" "♂") ("z(" "【")
    ("z0" "♀") ("z)" "】")
    ("z-" "〜") ("z_" "∴")
    ("z=" "≠") ("z+" "±")
    ("z\\" "＼") ("z|" "‖")
    ("z`" "´") ("z~" "¨")

    ("zq" "《") ("zQ" "〈")
    ("zw" "》") ("zW" "〉")
    ("zr" "々") ("zR" "仝")
    ("zt" "〆") ("zT" "§")
    ("zp" "〒") ("zP" "↑")
    ("z[" "『") ("z{" "〔")
    ("z]" "』") ("z}" "〕")

    ("zs" "ヽ") ("zS" "ヾ")
    ("zd" "ゝ") ("zD" "ゞ")
    ("zf" "〃") ("zF" "→")
    ("zg" "‐") ("zG" "—")
    ("zh" "←")
    ("zj" "↓")
    ("zk" "↑")
    ("zl" "→")
    ("z;" "゛") ("z:" "゜")
    ("z'" "‘") ("z\"" "“")

    ("zx" "’") ("zX" "”")
    ("zc" "〇") ("zC" "℃")
    ("zv" "※") ("zV" "÷")
    ("zb" "°") ("zB" "←")
    ("zn" "′") ("zN" "↓")
    ("zm" "″") ("zM" "〓")
    ("z," "‥") ("z<" "≦")
    ("z." "…") ("z>" "≧")
    ("z/" "・") ("z?" "∞"))))

;;; kkh

(defvar kkh-rules nil
  "ASCII 文字列とかなの対応の連想配列.")

(defvar kkh-rules-pattern nil
  "かなに変換する ASCII 文字列の正規表現.")

(defvar kkh-default-layout-name "uskana"
  "デフォルトのかな入力配列名 (文字列).")

(defvar kkh-current-layout nil
  "現在選択されているかな入力配列.")

(defvar kkh-previous-layout nil
  "直前に選択されていたかな入力配列.")

(defun kkh-set-layout (layout)
  "かな入力配列 LAYOUT に設定する."
  (let ((name (car layout))
        (rules (nth 3 layout)))
    (setq kkh-rules (copy-alist rules))
    ;; ASCII 文字列の長さで降順ソートしておく
    (setq kkh-rules
          (sort kkh-rules
                (lambda (a b) (< (length (car b)) (length (car a))))))
    (setq kkh-rules-pattern
          (concat "\\(.*?\\)\\("
                  (mapconcat (lambda (s) (regexp-quote s))
                             (mapcar (lambda (rule) (car rule)) kkh-rules)
                             "\\|")
                  "\\)\\(.*\\)"))
    (if (not (equal name (car kkh-current-layout)))
        (setq kkh-previous-layout kkh-current-layout
              kkh-current-layout layout))))

;; (kkh-set-layout (car kkh-layouts))

(defun kkh-select-layout ()
  "配列を選択する."
  (interactive)
  (when (equal current-input-method "japanese-kkh")
    (let* ((prev-name (car kkh-previous-layout))
           (curr-name (car kkh-current-layout))
           (all-names (mapcar #'car kkh-layouts))
           (names nil)
           (names (if curr-name (cons curr-name names) names))
           (names (if prev-name (cons prev-name names) names))
           (names (dolist (name all-names names)
                    (add-to-list 'names name t)))
           (name (ido-completing-read
                  "Layout: " names nil t))
           (layout (assoc name kkh-layouts)))
      (kkh-set-layout layout))))

(defun kkh-to-kana (str)
  "ASCII 文字列 STR をかなに変換した新しい文字列を返す."
  (let ((case-fold-search nil))
    (save-match-data
      (while (string-match kkh-rules-pattern str)
        (setq str (concat (match-string 1 str)
                          (cadr (assoc (match-string 2 str) kkh-rules))
                          (match-string 3 str))))
      str)))

(defvar kkh-special-rules
  '(("ゎ" "ﾜﾟ") ("ゐ" "ｲﾟ") ("ゑ" "ｴﾟ") ("ヵ" "ｶﾟ") ("ヶ" "ｹﾟ"))
  "全角ひらがなと半角カナの便宜的な対応の連想配列.")

(defvar kkh-special-rules-pattern
  (concat "\\(.*?\\)\\("
          (mapconcat (lambda (s) (regexp-quote s))
                     (mapcar (lambda (rule) (car rule)) kkh-special-rules)
                     "\\|")
          "\\)\\(.*\\)")
  "半角カナに便宜的に変換するかなの正規表現.")

(defun kkh-special (str)
  "STR 中の全角ひらがなを半角カナに便宜的に変換した新しい文字列を返す."
  (let ((case-fold-search nil))
    (save-match-data
      (while (string-match kkh-special-rules-pattern str)
        (setq str (concat (match-string 1 str)
                          (cadr (assoc (match-string 2 str) kkh-special-rules))
                          (match-string 3 str))))
      str)))

(defun kkh-to-hiragana (str)
  "STR をひらがな文字列に変換した新しい文字列を返す."
  (kkh-to-kana str))

(defun kkh-to-katakana (str)
  "STR をカタカナ文字列に変換した新しい文字列を返す."
  (japanese-katakana (kkh-to-kana str)))

(defun kkh-to-zenkaku (str)
  "STR を全角英字変換した新しい文字列を返す."
  (japanese-zenkaku str))

(defun kkh-to-hankaku (str)
  "STR を半角カナ変換した新しい文字列を返す."
  (japanese-hankaku (kkh-special (kkh-to-kana str))))

;;

;; (defun kkh-translit-toggle-hankaku-zenkaku ()
;;   (interactive)
;;   (setq quail-translating nil)
;;   (let* ((start (overlay-start quail-conv-overlay))
;;          (end (overlay-end quail-conv-overlay))
;;          (ascii (buffer-substring start end))
;;          (hankaku (kkh-to-hankaku quail-conversion-str))
;;          (zenkaku (kkh-to-zenkaku quail-conversion-str))
;;          (str (if (not (string= hankaku ascii)) hankaku zenkaku)))
;;     ;; (setq quail-conversion-str str)
;;     (message "<%S><%S>" str quail-conversion-str)
;;     (save-excursion ;; (goto-char start)
;;                     (kkh-replace-region start end str)))
;;   (setq quail-current-key nil)
;;   (setq quail-current-str nil))

;;

;; (defun kkh-translit-translate (fn)
;;   (setq quail-translating nil)
;;   (let* ((start (overlay-start quail-conv-overlay))
;;          (end (overlay-end quail-conv-overlay))
;;          (ascii (buffer-substring start end))
;;          (str (apply fn (list ascii))))
;;     (save-excursion (goto-char start)
;;                     (kkh-replace-region start end str))
;;     (setq quail-conversion-str str))
;;   (setq quail-current-key nil)
;;   (setq quail-current-str nil)
;;   (quail-no-conversion))

;; (defun kkh-translit-hiragana ()
;;   (interactive)
;;   (kkh-translit-translate #'kkh-to-hiragana))

;; (defun kkh-translit-katakana ()
;;   (interactive)
;;   (kkh-translit-translate #'kkh-to-katakana))

;; (defun kkh-translit-zenkaku ()
;;   (interactive)
;;   (kkh-translit-translate #'kkh-to-zenkaku))

;; (defun kkh-translit-hankaku ()
;;   (interactive)
;;   (kkh-translit-translate #'kkh-to-hankaku))

;;

(defun kkh-translit-commit-hiragana ()
  "ひらがなに確定する."
  (interactive)
  (setq quail-conversion-str (kkh-to-hiragana quail-conversion-str))
  (quail-no-conversion))

(defun kkh-translit-commit-katakana ()
  "カタカナに確定する."
  (interactive)
  (setq quail-conversion-str (kkh-to-katakana quail-conversion-str))
  (quail-no-conversion))

(defun kkh-translit-commit-zenkaku ()
  "全角英字に確定する."
  (interactive)
  (setq quail-conversion-str (kkh-to-zenkaku quail-conversion-str))
  (quail-no-conversion))

(defun kkh-translit-commit-hankaku ()
  "半角カナに確定する."
  (interactive)
  (setq quail-conversion-str (kkh-to-hankaku quail-conversion-str))
  (quail-no-conversion))

(defun kkh-translit-cancel ()
  "変換をキャンセルし, 消去する."
  (interactive)
  (setq quail-conversion-str "")
  (quail-no-conversion))

;;

;; japanese-replace-region from japan-util.el.gz

(defun kkh-replace-region (from to string)
  "Replace the region specified by FROM and TO to STRING."
  (goto-char from)
  (insert string)
  (delete-char (- to from)))

(defun kkh-translit-hiragana-region (from to)
  "FROM から TO までのリージョンをひらがなに変換して置換する."
  (interactive "r")
  (let* ((ascii (buffer-substring from to))
         (hiragana (kkh-to-hiragana ascii)))
    (kkh-replace-region from to hiragana)))

(defun kkh-translit-convert ()
  "KKH (Kana Kanji Henkan) により漢字に変換する."
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
        (let ((result (kkh-region from (+ from len))))
          (move-overlay quail-conv-overlay from (point))
          (setq quail-conversion-str (buffer-substring from (point)))
          (if (= (+ from result) (point))
              (setq quail-converting nil))
          (setq quail-translating nil))
      (set-marker from nil))))

(defun kkh-translit-insert-space ()
  "読みとしての空白を挿入する."
  (interactive)
  (setq quail-current-key (concat quail-current-key " "))
  (or (catch 'quail-tag
        (quail-update-translation (quail-translate-key))
        t)
      ;; If someone throws for `quail-tag' by value nil, we exit from
      ;; translation mode.
      (setq quail-translating nil)))

;;; natural cursor

(defvar kkh-natural-cursor-enabled t
  "非 nil なら, ナチュラルカーソルを有効化する.")

(defun kkh-translit-backward-char ()
  (interactive)
  (if kkh-natural-cursor-enabled
      (if (<= (point) (overlay-start quail-conv-overlay))
          (let* ((start (overlay-start quail-conv-overlay))
                 (end (overlay-end quail-conv-overlay))
                 (len (- end start))
                 (events (make-list (1+ len) last-command-event)))
            (quail-no-conversion)
            (setq unread-command-events (append unread-command-events events)))
        (setq quail-translating nil)
        (forward-char -1))
    (quail-conversion-backward-char)))

(defun kkh-translit-forward-char ()
  (interactive)
  (if kkh-natural-cursor-enabled
      (if (>= (point) (overlay-end quail-conv-overlay))
          (let ((events (list last-command-event)))
            (quail-no-conversion)
            (setq unread-command-events (append unread-command-events events)))
        (setq quail-translating nil)
        (forward-char 1))
    (quail-conversion-forward-char)))

(defun kkh-translit-beginning-of-region ()
  (interactive)
  (if kkh-natural-cursor-enabled
      (if (<= (point) (overlay-start quail-conv-overlay))
          (let ((events (list last-command-event)))
            (quail-no-conversion)
            (setq unread-command-events (append unread-command-events events)))
        (setq quail-translating nil)
        (goto-char (overlay-start quail-conv-overlay)))
    (quail-conversion-beginning-of-region)))

(defun kkh-translit-end-of-region ()
  (interactive)
  (if kkh-natural-cursor-enabled
      (if (>= (point) (overlay-end quail-conv-overlay))
          (let ((events (list last-command-event)))
            (quail-no-conversion)
            (setq unread-command-events (append unread-command-events events)))
        (setq quail-translating nil)
        (goto-char (overlay-end quail-conv-overlay)))
    (quail-conversion-end-of-region)))

(defun kkh-translit-delete-char ()
  (interactive)
  (setq quail-translating nil)
  (if kkh-natural-cursor-enabled
      (if (>= (point) (overlay-end quail-conv-overlay))
          (let ((events (list last-command-event)))
            (quail-no-conversion)
            (setq unread-command-events (append unread-command-events events)))
        (delete-char 1)
        (let ((start (overlay-start quail-conv-overlay))
              (end (overlay-end quail-conv-overlay)))
          (setq quail-conversion-str (buffer-substring start end))
          (if (= start end)
              (setq quail-converting nil))))
    (quail-conversion-delete-char)))

(defun kkh-translit-delete-tail ()
  (interactive)
  (if kkh-natural-cursor-enabled
      (if (>= (point) (overlay-end quail-conv-overlay))
          (let ((events (list last-command-event)))
            (quail-no-conversion)
            (setq unread-command-events (append unread-command-events events)))
        (delete-region (point) (overlay-end quail-conv-overlay))
        (let ((start (overlay-start quail-conv-overlay))
              (end (overlay-end quail-conv-overlay)))
          (setq quail-conversion-str (buffer-substring start end))
          (if (= start end)
              (setq quail-converting nil))))
    (quail-conversion-delete-tail)))

(defun kkh-translit-backward-delete-char ()
  (interactive)
  (if kkh-natural-cursor-enabled
      (if (> (length quail-current-key) 0)
          (quail-delete-last-char)
        (if (<= (point) (overlay-start quail-conv-overlay))
            (let ((events (list last-command-event)))
              (quail-no-conversion)
              (setq unread-command-events (append unread-command-events events)))
          (delete-char -1)
          (let ((start (overlay-start quail-conv-overlay))
                (end (overlay-end quail-conv-overlay)))
            (setq quail-conversion-str (buffer-substring start end))
            (if (= start end)
                (setq quail-converting nil)))))
    (quail-conversion-backward-delete-char)))

(defun kkh-translit-space ()
  (interactive)
  (if kkh-natural-cursor-enabled
      (let ((start (overlay-start quail-conv-overlay))
            (end (overlay-end quail-conv-overlay))
            (pos (point)))
        (if (and start
                 (> pos start)
                 (< pos end))
            (kkh-translit-insert-space)
          (let ((events (list last-command-event)))
            (quail-no-conversion)
            (when (<= pos start)
              (setq events (append (make-list (- end start) ?\C-b) events))) ; XXX
            (setq unread-command-events (append unread-command-events events)))))
    (quail-no-conversion)
    (setq unread-command-events (append unread-command-events
                                        (list last-command-event)))))

;;; かな漢字変換による日本語入力メソッド

(quail-define-package
 "japanese-kkh" "Japanese" "か"
 nil
 "Japanese input method by Kana Kanji Henkan.
"
 nil t t nil nil nil nil nil
 nil                               ; #'kkh-translit-update-translation
 '(("\C-a" . kkh-translit-beginning-of-region)
   ("\C-b" . kkh-translit-backward-char)
   ("\C-d" . kkh-translit-delete-char)
   ("\C-e" . kkh-translit-end-of-region)
   ("\C-f" . kkh-translit-forward-char)
   ("\C-g" . kkh-translit-cancel)
   ("\C-j" . kkh-translit-convert)
   ("\C-k" . kkh-translit-commit-katakana)
   ("\C-l" . quail-no-conversion)
   ("\C-o" . kkh-translit-commit-hankaku)
   ("\C-u" . kkh-translit-commit-hiragana)
   ("\C-t" . kkh-translit-commit-zenkaku)
   ("\177" . kkh-translit-backward-delete-char)
   ([delete] . kkh-translit-backward-delete-char)
   ([backspace] . kkh-translit-backward-delete-char)
   ;; (" " . nil)
   (" " . kkh-translit-space)
   ([?\S- ] . kkh-translit-insert-space))
 nil                                    ; t
 )

;; 空白を除く ASCII 文字 [!-~] キーで, その文字自身を入力
(let ((c 33))                           ; (c 32)
  (while (< c 127)
    (quail-defrule (char-to-string c) (char-to-string c))
    (setq c (1+ c))))

;; Update Quail translation region.
(defun kkh-translit-update-translation (control-flag)
  (cond ((null control-flag)
         (setq quail-current-str (or quail-current-str quail-current-key)))
        ((integerp control-flag)
         (setq unread-command-events
               (append (substring quail-current-key control-flag)
                       unread-command-events)))
        (t nil))
  control-flag)

;;; kkh

(require 'url-http)
(require 'json)

(defvar kkh-partial-cancel nil
  "非 nil なら, `kkh-cancel' のときに確定した文節を ASCII 文字列に戻さない.")

(defvar kkh-select-to-commit t
  "非 nil なら, 候補リストから選択したあとに確定する.")

(defvar kkh-url-show-status nil
  "nil のとき, \"Contacting host ...\" の表示を抑制する.")

(defun kkh-google-transliterate (string)
  "ひらがな文字列 STRING を Google Transliterate して結果をリストにして返す.

- Google 日本語入力 - CGI API デベロッパーガイド
- https://www.google.co.jp/ime/cgiapi.html"
  (let* ((coding-system 'utf-8)
         (encoded (url-hexify-string (encode-coding-string string 'utf-8)))
         (url "http://www.google.com/transliterate?langpair=ja-Hira|ja&text=")
         (url (concat url encoded))
         (url-request-method "GET")
         (url-max-redirections 0)
         (url-show-status (and kkh-url-show-status url-show-status))
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

;;
(defvar kkh-use-ja-dic nil
  "非 nil のとき, `kkh-lookup-key-sub' の代わりに `skkdic-lookup-key' を使う.")

(defvar kkh-use-ja-dic-temporally t
  "非 nil のとき, 文節確定ごとに `kkh-use-ja-dic' を nil にリセットする.")

(defun kkh-toggle-use-ja-dic ()
  "`kkh-use-ja-dic' をトグルする."
  (interactive)
  (setq kkh-use-ja-dic (not kkh-use-ja-dic))
  (message "%s" (if kkh-use-ja-dic "Using ja-dic" "Using Google API"))
  (kkh-lookup-key kkh-length-head)
  (kkh-update-conversion 'all))

(require 'ja-dic-utl)
;; /

(defvar kkh-input-method-title "漢"
  "String denoting KKH input method.
This string is shown at mode line when users are in KKH mode.")

;; (defvar kkh-init-file-name (locate-user-emacs-file "kkcrc" ".kkcrc")
;;   "Name of a file which contains user's initial setup code for KKH.")

;; A flag to control a file specified by `kkh-init-file-name'.
;; The value nil means the file is not yet consulted.
;; The value t means the file has already been consulted but there's
;; no need of updating it yet.
;; Any other value means that we must update the file before exiting Emacs.
;; (defvar kkh-init-file-flag nil)

;; Cash data for `kkh-lookup-key'.  This may be initialized by loading
;; a file specified by `kkh-init-file-name'.  If any elements are
;; modified, the data is written out to the file when exiting Emacs.
;; (defvar kkh-lookup-cache nil)

;; Tag symbol of `kkh-lookup-cache'.
;; (defconst kkh-lookup-cache-tag 'kkh-lookup-cache-2)

;; (defun kkh-save-init-file ()
;;   "Save initial setup code for KKH to a file specified by `kkh-init-file-name'."
;;   (if (and kkh-init-file-flag
;;            (not (eq kkh-init-file-flag t)))
;;       (let ((coding-system-for-write 'iso-2022-7bit)
;;             (print-length nil))
;;         (write-region (format "(setq kkh-lookup-cache '%S)\n" kkh-lookup-cache)
;;                       nil
;;                       kkh-init-file-name))))

;; Sequence of characters to be used for indexes for shown list.  The
;; Nth character is for the Nth conversion in the list currently shown.
(defvar kkh-show-conversion-list-index-chars
  "1234567890")

;; 0 .. 9 の代わりに C-0 .. C-9 で候補を選択する
(defvar kkh-conversion-list-index-keys
  (apply #'vconcat
         (mapcar (function (lambda (c) (kbd (format "C-%c" c))))
                 (string-to-vector kkh-show-conversion-list-index-chars))))

(defun kkh-help ()
  "Show key bindings available while converting by KKH."
  (interactive)
  ;; (with-output-to-temp-buffer "*Help*"
  ;;   (princ (substitute-command-keys "\\{kkh-keymap}")))
  (with-output-to-temp-buffer "*Help*"
    (with-current-buffer standard-output
      (quail-help-insert-keymap-description kkh-keymap)))
  ;; /
  )

(defvar kkh-keymap
  (let ((map (make-sparse-keymap))
        (len (length kkh-show-conversion-list-index-chars))
        (i 0))
    (while (< i len)
      ;; (define-key map
      ;;   (char-to-string (aref kkh-show-conversion-list-index-chars i))
      ;;   'kkh-select-from-list)
      (define-key map
                  (make-vector 1 (aref kkh-conversion-list-index-keys i))
                  'kkh-select-from-list)
      ;; /
      (setq i (1+ i)))
    ;; (define-key map " " 'kkh-next)
    ;; (define-key map "\r" 'kkh-terminate)
    ;; (define-key map "\C-@" 'kkh-first-char-only)
    ;; (define-key map "\C-n" 'kkh-next)
    ;; (define-key map "\C-p" 'kkh-prev)
    ;; (define-key map "\C-i" 'kkh-shorter)
    ;; (define-key map "\C-o" 'kkh-longer)
    ;; (define-key map "I" 'kkh-shorter-conversion)
    ;; (define-key map "O" 'kkh-longer-phrase)
    ;; (define-key map "\C-c" 'kkh-cancel)
    ;; (define-key map "\C-?" 'kkh-cancel)
    ;; (define-key map "\C-f" 'kkh-next-phrase)
    ;; (define-key map "K" 'kkh-katakana)
    ;; (define-key map "H" 'kkh-hiragana)
    ;; (define-key map "l" 'kkh-show-conversion-list-or-next-group)
    ;; (define-key map "L" 'kkh-show-conversion-list-or-prev-group)
    ;; (define-key map [?\C- ] 'kkh-first-char-only)
    ;; (define-key map [delete] 'kkh-cancel)
    ;; (define-key map [return] 'kkh-terminate)
    ;; (define-key map "\C-h" 'kkh-help)
    ;;
    (define-key map "\C-@" 'kkh-first-char-only)
    (define-key map "\C-n" 'kkh-next)
    (define-key map "\C-p" 'kkh-prev)
    ;; (define-key map "\C-c" 'kkh-cancel)
    ;; (define-key map "\C-c" 'kkh-show-conversion-list-or-prev-group)
    (define-key map "\C-?" 'kkh-cancel)
    (define-key map "\C-f" 'kkh-next-phrase)
    (define-key map [?\C- ] 'kkh-first-char-only)
    (define-key map [delete] 'kkh-cancel)
    (define-key map "\C-v" 'kkh-show-conversion-list-or-next-group)
    (define-key map [?\C-\S-v] 'kkh-show-conversion-list-or-prev-group)
    ;; (define-key map "\M-v" 'kkh-show-conversion-list-or-prev-group)
    ;; (define-key map "\C-b" 'kkh-show-conversion-list-or-prev-group)
    ;; (define-key map [?\C-,] 'kkh-shorter)
    ;; (define-key map [?\C-.] 'kkh-longer)
    (define-key map [?\C-,] 'kkh-shorter-or-longest)
    (define-key map [?\C-.] 'kkh-longer-or-shortest)
    (define-key map [?\C-<] 'kkh-shorter-conversion)
    (define-key map [?\C->] 'kkh-longer-phrase)
    ;; (define-key map [escape] 'kkh-cancel)
    (define-key map "\C-g" 'kkh-cancel)
    (define-key map "\C-j" 'kkh-terminate)
    (define-key map "\C-k" 'kkh-conv-katakana)
    (define-key map "\C-l" 'kkh-conv-ascii)
    (define-key map "\C-o" 'kkh-conv-hankaku)
    (define-key map "\C-u" 'kkh-conv-hiragana)
    (define-key map "\C-t" 'kkh-conv-zenkaku)
    ;;
    (define-key map "\C-s" 'kkh-toggle-use-ja-dic)
    ;; /
    (define-key map "\C-h" 'kkh-help)
    ;;
    map)
  "Keymap for KKH (Kana Kanji Henkan).")

;;; Internal variables used in KKH.

;;
(defvar kkh-original-ascii nil
  "変換対象のもとの ASCII 文字列.")
;; /

;; The current Kana string to be converted.
(defvar kkh-original-kana nil)

;; The current key sequence (vector of Kana characters) generated from
;; `kkh-original-kana'.
(defvar kkh-current-key nil)

;; List of the current conversions for `kkh-current-key'.
(defvar kkh-current-conversions nil)

;; Vector of the same length as `kkh-current-conversion'.  The first
;; element is a vector of:
;;      o index number of the first conversion shown previously,
;;      o index number of a conversion next of the last one shown previously,
;;      o the shown string itself.
;; The remaining elements are widths (including columns for index
;; numbers) of conversions stored in the same order as in
;; `kkh-current-conversion'.
(defvar kkh-current-conversions-width nil)

(defcustom kkh-show-conversion-list-count 2 ; was: 4
  "Count of successive `kkh-next' or `kkh-prev' to show conversion list.
When you type C-n or C-p successively this count while using the input
method `japanese-kkh', the conversion candidates are shown in the echo
area while indicating the current selection by `<N>'."
  :group 'mule
  :type 'integer)

;; Count of successive invocations of `kkh-next'.
(defvar kkh-next-count nil)

;; Count of successive invocations of `kkh-prev'.
(defvar kkh-prev-count nil)

;; Provided that `kkh-current-key' is [A B C D E F G H I], the current
;; conversion target is [A B C D E F], and the sequence of which
;; conversion is found is [A B C D]:
;;
;;                                A B C D E F G H I
;; kkh-overlay-head (black):     |<--------->|
;; kkh-overlay-tail (underline):         |<------->|
;; kkh-length-head:              |<--------->|
;; kkh-length-converted:         |<----->|
;;
(defvar kkh-overlay-head nil)
(defvar kkh-overlay-tail nil)
(defvar kkh-length-head nil)
(defvar kkh-length-converted nil)
;;
(defvar kkh-length-commit nil
  "確定した文字列の長さ.")
;; /

;; Cursor type (`box' or `bar') of the current frame.
(defvar kkh-cursor-type nil)

;; Lookup Japanese dictionary to set list of conversions in
;; kkh-current-conversions for key sequence kkh-current-key of length
;; LEN.  If no conversion is found in the dictionary, don't change
;; kkh-current-conversions and return nil.
;; Postfixes are handled only if POSTFIX is non-nil.
;; (defun kkh-lookup-key (len &optional postfix prefer-noun)
;;   ;; At first, prepare cache data if any.
;;   (unless kkh-init-file-flag
;;     (setq kkh-init-file-flag t
;;           kkh-lookup-cache nil)
;;     (add-hook 'kill-emacs-hook 'kkh-save-init-file)
;;     (if (file-readable-p kkh-init-file-name)
;;         (condition-case nil
;;             (load-file kkh-init-file-name)
;;           (kkh-error "Invalid data in %s" kkh-init-file-name))))
;;   (or (and (nested-alist-p kkh-lookup-cache)
;;            (eq (car kkh-lookup-cache) kkh-lookup-cache-tag))
;;       (setq kkh-lookup-cache (list kkh-lookup-cache-tag)
;;             kkh-init-file-flag 'kkh-lookup-cache))
;;   (let ((entry (lookup-nested-alist kkh-current-key kkh-lookup-cache len 0 t)))
;;     (if (consp (car entry))
;;         (setq kkh-length-converted len
;;               kkh-current-conversions-width nil
;;               kkh-current-conversions (car entry))
;;       (setq entry (skkdic-lookup-key kkh-current-key len postfix prefer-noun))
;;       (if entry
;;           (progn
;;             (setq kkh-length-converted len
;;                   kkh-current-conversions-width nil
;;                   kkh-current-conversions (cons 1 entry))
;;             (if postfix
;;                 ;; Store this conversions in the cache.
;;                 (progn
;;                   (set-nested-alist kkh-current-key kkh-current-conversions
;;                                     kkh-lookup-cache kkh-length-converted)
;;                   (setq kkh-init-file-flag 'kkh-lookup-cache)))
;;             t)
;;         (if (= len 1)
;;             (setq kkh-length-converted 1
;;                   kkh-current-conversions-width nil
;;                   kkh-current-conversions (cons 0 nil)))))))

(defun kkh-lookup-key-sub (key len &optional postfix prefer-noun)
  "かなの配列 KEY の長さ LEN 分の変換候補のリストを返す.
`kkh-use-ja-dic' が非 nil なら, `skkdic-lookup-key' を呼び出す.
そうでなければ `kkh-google-transliterate' を呼び出す (この場合は,
POSTFIX と PREFER-NOUN は無視される)."
  (let* ((string (concat key))
         (string (substring string 0 len)))
    (if kkh-use-ja-dic
        (skkdic-lookup-key key len postfix prefer-noun)
      (car (kkh-google-transliterate (concat string ","))))))

;; Lookup Japanese dictionary to set list of conversions in
;; kkh-current-conversions for key sequence kkh-current-key of length
;; LEN.  If no conversion is found in the dictionary, don't change
;; kkh-current-conversions and return nil.
;; Postfixes are handled only if POSTFIX is non-nil.
(defun kkh-lookup-key (len &optional postfix prefer-noun)
  (let ((entry nil))
    (if (consp (car entry))
        (setq kkh-length-converted len
              kkh-current-conversions-width nil
              kkh-current-conversions (car entry))
      (setq entry (kkh-lookup-key-sub kkh-current-key len postfix prefer-noun))
      (if entry
          (progn
            (setq kkh-length-converted len
                  kkh-current-conversions-width nil
                  kkh-current-conversions (cons 1 entry))
            t)
        (if (= len 1)
            (setq kkh-length-converted 1
                  kkh-current-conversions-width nil
                  kkh-current-conversions (cons 0 nil)))))))

;; /

(define-error 'kkh-error nil)
(defun kkh-error (&rest args)
  (signal 'kkh-error (apply #'format-message args)))

(defvar kkh-converting nil)

;;;###autoload
(defvar kkh-after-update-conversion-functions nil
  "Functions to run after a conversion is selected in `japanese-kkh' input method.
With this input method, a user can select a proper conversion from
candidate list.  Each time he changes the selection, functions in this
list are called with two arguments; starting and ending buffer
positions that contains the current selection.")

;;;###autoload
(defun kkh-region (from to)
  "Convert Kana string in the current region to Kanji-Kana mixed string.
Users can select a desirable conversion interactively.
When called from a program, expects two arguments,
positions FROM and TO (integers or markers) specifying the target region.
When it returns, the point is at the tail of the selected conversion,
and the return value is the length of the conversion."
  (interactive "r")
  (setq kkh-original-ascii (buffer-substring from to))
  (save-excursion
    (goto-char from)
    (kkh-translit-hiragana-region from to)
    (setq to (point)))
  (setq kkh-original-kana (buffer-substring from to))
  (goto-char from)

  ;; Setup overlays.
  (if (overlayp kkh-overlay-head)
      (move-overlay kkh-overlay-head from to)
    (setq kkh-overlay-head (make-overlay from to nil nil t))
    (overlay-put kkh-overlay-head 'face 'highlight))
  (if (overlayp kkh-overlay-tail)
      (move-overlay kkh-overlay-tail to to)
    (setq kkh-overlay-tail (make-overlay to to nil nil t))
    (overlay-put kkh-overlay-tail 'face 'underline))

  (setq kkh-current-key (string-to-vector kkh-original-kana))
  (setq kkh-length-head (length kkh-current-key))
  (setq kkh-length-converted 0)
  ;;
  (setq kkh-length-commit 0)
  ;; (setq kkh-use-ja-dic nil)
  (when kkh-use-ja-dic-temporally
    (setq kkh-use-ja-dic nil))
  ;; /

  (unwind-protect
      ;; At first convert the region to the first candidate.
      (let ((current-input-method-title kkh-input-method-title)
            (input-method-function nil)
            (modified-p (buffer-modified-p))
            (first t))
        (while (not (kkh-lookup-key kkh-length-head nil first))
          (setq kkh-length-head (1- kkh-length-head)
                first nil))
        (goto-char to)
        (kkh-update-conversion 'all)
        (setq kkh-next-count 1 kkh-prev-count 0)
        (if (and (>= kkh-next-count kkh-show-conversion-list-count)
                 (>= (length kkh-current-conversions) 3))
            (kkh-show-conversion-list-or-next-group))

        ;; Then, ask users to select a desirable conversion.
        (force-mode-line-update)
        (setq kkh-converting t)
        ;; Hide "... loaded" message.
        (message nil)
        (while kkh-converting
          (set-buffer-modified-p modified-p)
          (let* ((overriding-terminal-local-map kkh-keymap)
                 (help-char nil)
                 (keyseq (read-key-sequence nil))
                 (cmd (lookup-key kkh-keymap keyseq)))
            (if (commandp cmd)
                (condition-case err
                    (progn
                      (cond ((eq cmd 'kkh-next)
                             (setq kkh-next-count (1+ kkh-next-count)
                                   kkh-prev-count 0))
                            ((eq cmd 'kkh-prev)
                             (setq kkh-prev-count (1+ kkh-prev-count)
                                   kkh-next-count 0))
                            (t
                             (setq kkh-next-count 0 kkh-prev-count 0)))
                      (call-interactively cmd))
                  (kkh-error (message "%s" (cdr err)) (beep)))
              ;; KEYSEQ is not defined in KKH keymap.
              ;; Let's put the event back.
              (setq unread-input-method-events
                    (append (string-to-list (this-single-command-raw-keys))
                            unread-input-method-events))
              (kkh-terminate))))

        (force-mode-line-update)
        (goto-char (overlay-end kkh-overlay-tail))
        (- (overlay-start kkh-overlay-head) from))
    (delete-overlay kkh-overlay-head)
    (delete-overlay kkh-overlay-tail)))

(defun kkh-terminate ()
  "Exit from KKH mode by fixing the current conversion."
  (interactive)
  (goto-char (overlay-end kkh-overlay-tail))
  (move-overlay kkh-overlay-head (point) (point))
  (setq kkh-converting nil))

(defun kkh-cancel ()
  "Exit from KKH mode by canceling any conversions."
  (interactive)
  (goto-char (overlay-start kkh-overlay-head))
  (delete-region (overlay-start kkh-overlay-head)
                 (overlay-end kkh-overlay-tail))
  ;; (insert kkh-original-kana)
  ;; XXX
  (if kkh-partial-cancel
      (insert (kkh-conv-to-ascii))
    (delete-region (- (point) kkh-length-commit) (point))
    (insert kkh-original-ascii))
  ;; /
  (setq kkh-converting nil))

(defun kkh-first-char-only ()
  "Select only the first character currently converted."
  (interactive)
  (goto-char (overlay-start kkh-overlay-head))
  (forward-char 1)
  (delete-region (point) (overlay-end kkh-overlay-tail))
  (kkh-terminate))

;; (defun kkh-next ()
;;   "Select the next candidate of conversion."
;;   (interactive)
;;   (let ((idx (1+ (car kkh-current-conversions))))
;;     (if (< idx 0)
;;         (setq idx 1))
;;     (if (>= idx (length kkh-current-conversions))
;;         (setq idx 0))
;;     (setcar kkh-current-conversions idx)
;;     (if (> idx 1)
;;         (progn
;;           (set-nested-alist kkh-current-key kkh-current-conversions
;;                             kkh-lookup-cache kkh-length-converted)
;;           (setq kkh-init-file-flag 'kkh-lookup-cache)))
;;     (if (or kkh-current-conversions-width
;;             (>= kkh-next-count kkh-show-conversion-list-count))
;;         (kkh-show-conversion-list-update))
;;     (kkh-update-conversion)))

(defun kkh-next ()
  "Select the next candidate of conversion."
  (interactive)
  (let ((idx (1+ (car kkh-current-conversions))))
    (if (< idx 0)
        (setq idx 1))
    (if (>= idx (length kkh-current-conversions))
        (setq idx 0))
    (setcar kkh-current-conversions idx)
    (if (or kkh-current-conversions-width
            (>= kkh-next-count kkh-show-conversion-list-count))
        (kkh-show-conversion-list-update))
    (kkh-update-conversion)))

;; (defun kkh-prev ()
;;   "Select the previous candidate of conversion."
;;   (interactive)
;;   (let ((idx (1- (car kkh-current-conversions))))
;;     (if (< idx 0)
;;         (setq idx (1- (length kkh-current-conversions))))
;;     (setcar kkh-current-conversions idx)
;;     (if (> idx 1)
;;         (progn
;;           (set-nested-alist kkh-current-key kkh-current-conversions
;;                             kkh-lookup-cache kkh-length-converted)
;;           (setq kkh-init-file-flag 'kkh-lookup-cache)))
;;     (if (or kkh-current-conversions-width
;;             (>= kkh-prev-count kkh-show-conversion-list-count))
;;         (kkh-show-conversion-list-update))
;;     (kkh-update-conversion)))

(defun kkh-prev ()
  "Select the previous candidate of conversion."
  (interactive)
  (let ((idx (1- (car kkh-current-conversions))))
    (if (< idx 0)
        (setq idx (1- (length kkh-current-conversions))))
    (setcar kkh-current-conversions idx)
    (if (or kkh-current-conversions-width
            (>= kkh-prev-count kkh-show-conversion-list-count))
        (kkh-show-conversion-list-update))
    (kkh-update-conversion)))

;; /

(defun kkh-select-from-list ()
  "Select one candidate from the list currently shown in echo area."
  (interactive)
  (let (idx
        ;;
        (kkh-show-conversion-list-index-chars kkh-conversion-list-index-keys))
    ;; /
    (if kkh-current-conversions-width
        (let ((len (length kkh-show-conversion-list-index-chars))
              (maxlen (- (aref (aref kkh-current-conversions-width 0) 1)
                         (aref (aref kkh-current-conversions-width 0) 0)))
              (i 0))
          (if (> len maxlen)
              (setq len maxlen))
          (while (< i len)
            (if (= (aref kkh-show-conversion-list-index-chars i)
                   last-input-event)
                (setq idx i i len)
              (setq i (1+ i))))))
    (if idx
        (progn
          (setcar kkh-current-conversions
                  (+ (aref (aref kkh-current-conversions-width 0) 0) idx))
          (kkh-show-conversion-list-update)
          ;; (kkh-update-conversion))
          (kkh-update-conversion)
          (when kkh-select-to-commit
            (kkh-next-phrase)
            ;; Hide list.
            (message nil)))
      ;; /
      (setq unread-input-method-events
            (cons last-input-event unread-input-method-events))
      (kkh-terminate))))

(defun kkh-katakana ()
  "Convert to Katakana."
  (interactive)
  (setcar kkh-current-conversions -1)
  (kkh-update-conversion 'all))

(defun kkh-hiragana ()
  "Convert to hiragana."
  (interactive)
  (setcar kkh-current-conversions 0)
  (kkh-update-conversion))

(defun kkh-shorter ()
  "Make the Kana string to be converted shorter."
  (interactive)
  (if (<= kkh-length-head 1)
      (kkh-error "Can't be shorter"))
  (setq kkh-length-head (1- kkh-length-head))
  (if (> kkh-length-converted kkh-length-head)
      (let ((len kkh-length-head))
        (setq kkh-length-converted 0)
        (while (not (kkh-lookup-key len))
          (setq len (1- len)))))
  (kkh-update-conversion 'all))

(defun kkh-longer ()
  "Make the Kana string to be converted longer."
  (interactive)
  (if (>= kkh-length-head (length kkh-current-key))
      (kkh-error "Can't be longer"))
  (setq kkh-length-head (1+ kkh-length-head))
  ;; This time, try also entries with postfixes.
  (kkh-lookup-key kkh-length-head 'postfix)
  (kkh-update-conversion 'all))

;;

(defun kkh-shorter-or-longest ()
  "Make the Kana string to be converted shorter.
If already shortest, make it longest."
  (interactive)
  (if (<= kkh-length-head 1)
      ;; すでに最短なら, 最長にする
      (kkh-lookup-key (setq kkh-length-head (length kkh-current-key)))
    ;; 縮める
    (if (> kkh-length-converted (setq kkh-length-head (1- kkh-length-head)))
        (let ((len kkh-length-head))
          (setq kkh-length-converted 0)
          (while (not (kkh-lookup-key len))
            (setq len (1- len))))))
  (kkh-update-conversion 'all))

(defun kkh-longer-or-shortest ()
  "Make the Kana string to be converted longer.
If already longest, make it shortest."
  (interactive)
  (if (>= kkh-length-head (length kkh-current-key))
      ;; すでに最長なら, 最短にする
      (if (> kkh-length-converted (setq kkh-length-head 1))
          (let ((len kkh-length-head))
            (setq kkh-length-converted 0)
            (while (not (kkh-lookup-key len))
              (setq len (1- len)))))
    ;; 伸ばす
    ;; This time, try also entries with postfixes.
    (kkh-lookup-key (setq kkh-length-head (1+ kkh-length-head)) 'postfix))
  (kkh-update-conversion 'all))

;; /

(defun kkh-shorter-conversion ()
  "Make the Kana string to be converted shorter."
  (interactive)
  (if (<= kkh-length-converted 1)
      (kkh-error "Can't be shorter"))
  (let ((len (1- kkh-length-converted)))
    (setq kkh-length-converted 0)
    (while (not (kkh-lookup-key len))
      (setq len (1- len))))
  (kkh-update-conversion 'all))

(defun kkh-longer-phrase ()
  "Make the current phrase (BUNSETSU) longer without looking up dictionary."
  (interactive)
  (if (>= kkh-length-head (length kkh-current-key))
      (kkh-error "Can't be longer"))
  (setq kkh-length-head (1+ kkh-length-head))
  (kkh-update-conversion 'all))

(defun kkh-next-phrase ()
  "Fix the currently converted string and try to convert the remaining string."
  (interactive)
  (if (>= kkh-length-head (length kkh-current-key))
      (kkh-terminate)
    (setq kkh-length-head (- (length kkh-current-key) kkh-length-head))
    (goto-char (overlay-end kkh-overlay-head))
    (while (and (< (point) (overlay-end kkh-overlay-tail))
                (looking-at "\\CH"))
      (goto-char (match-end 0))
      (setq kkh-length-head (1- kkh-length-head)))
    (if (= kkh-length-head 0)
        (kkh-terminate)
      (let ((newkey (make-vector kkh-length-head 0))
            (idx (- (length kkh-current-key) kkh-length-head))
            (len kkh-length-head)
            (i 0))
        ;; For the moment, (setq kkh-original-kana (concat newkey))
        ;; doesn't work.
        (setq kkh-original-kana "")
        (while (< i kkh-length-head)
          (aset newkey i (aref kkh-current-key (+ idx i)))
          (setq kkh-original-kana
                (concat kkh-original-kana (char-to-string (aref newkey i))))
          (setq i (1+ i)))
        ;;
        (setq kkh-length-commit
              (+ kkh-length-commit
                 (- (length kkh-current-key) (length newkey))))
        ;; (setq kkh-use-ja-dic nil)
        (when kkh-use-ja-dic-temporally
          (setq kkh-use-ja-dic nil))
        ;; /
        (setq kkh-current-key newkey)
        (setq kkh-length-converted 0)
        (while (and (not (kkh-lookup-key kkh-length-head nil
                                         (< kkh-length-head len)))
                    (> kkh-length-head 1))
          (setq kkh-length-head (1- kkh-length-head)))
        (let ((pos (point))
              (tail (overlay-end kkh-overlay-tail)))
          (move-overlay kkh-overlay-head pos tail)
          (move-overlay kkh-overlay-tail tail tail))
        (kkh-update-conversion 'all)))))

;; We'll show users a list of available conversions in echo area with
;; index numbers so that users can select one conversion with the
;; number.

;; Set `kkh-current-conversions-width'.
(defun kkh-setup-current-conversions-width ()
  (let ((convs (cdr kkh-current-conversions))
        (len (length kkh-current-conversions))
        (idx 1))
    (setq kkh-current-conversions-width (make-vector len nil))
    ;; To tell `kkh-show-conversion-list-update' to generate
    ;; message from scratch.
    (aset kkh-current-conversions-width 0 (vector len -2 nil))
    ;; Fill the remaining slots.
    (while convs
      (aset kkh-current-conversions-width idx
            (+ (string-width (car convs)) 4))
      (setq convs (cdr convs)
            idx (1+ idx)))))

(defun kkh-show-conversion-list-or-next-group ()
  "Show list of available conversions in echo area with index numbers.
If the list is already shown, show the next group of conversions,
and change the current conversion to the first one in the group."
  (interactive)
  (if (< (length kkh-current-conversions) 3)
      (kkh-error "No alternative"))
  (if kkh-current-conversions-width
      (let ((next-idx (aref (aref kkh-current-conversions-width 0) 1)))
        (if (< next-idx (length kkh-current-conversions-width))
            (setcar kkh-current-conversions next-idx)
          (setcar kkh-current-conversions 1))
        (kkh-show-conversion-list-update)
        (kkh-update-conversion))
    (kkh-setup-current-conversions-width)
    (kkh-show-conversion-list-update)))

(defun kkh-show-conversion-list-or-prev-group ()
  "Show list of available conversions in echo area with index numbers.
If the list is already shown, show the previous group of conversions,
and change the current conversion to the last one in the group."
  (interactive)
  (if (< (length kkh-current-conversions) 3)
      (kkh-error "No alternative"))
  (if kkh-current-conversions-width
      (let ((this-idx (aref (aref kkh-current-conversions-width 0) 0)))
        (if (> this-idx 1)
            (setcar kkh-current-conversions (1- this-idx))
          (setcar kkh-current-conversions
                  (1- (length kkh-current-conversions-width))))
        (kkh-show-conversion-list-update)
        (kkh-update-conversion))
    (kkh-setup-current-conversions-width)
    (kkh-show-conversion-list-update)))

;; Update the conversion list shown in echo area.
(defun kkh-show-conversion-list-update ()
  (or kkh-current-conversions-width
      (kkh-setup-current-conversions-width))
  (let* ((current-idx (car kkh-current-conversions))
         (first-slot (aref kkh-current-conversions-width 0))
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
        (let ((len (length kkh-current-conversions))
              (max-width (window-width (minibuffer-window)))
              (width-table kkh-current-conversions-width)
              (width 0)
              (idx this-idx)
              (max-items (length kkh-show-conversion-list-index-chars))
              l)
          ;; Set THIS-IDX to the first index of conversion to be shown
          ;; in MSG, and reflect it in kkh-current-conversions-width.
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
          ;; kkh-current-conversions-width.
          (while (and (< idx len)
                      (<= (+ width (aref width-table idx)) max-width)
                      (< (- idx this-idx) max-items))
            (setq width (+ width (aref width-table idx))
                  idx (1+ idx)
                  l (cdr l)))
          (aset first-slot 1 (setq next-idx idx))
          (setq l (nthcdr this-idx kkh-current-conversions))
          (setq msg (format " %c %s"
                            (aref kkh-show-conversion-list-index-chars 0)
                            (propertize (car l)
                                        'kkh-conversion-index this-idx))
                idx (1+ this-idx)
                l (cdr l))
          (while (< idx next-idx)
            (setq msg (format "%s  %c %s"
                              msg
                              (aref kkh-show-conversion-list-index-chars
                                    (- idx this-idx))
                              (propertize (car l)
                                          'kkh-conversion-index idx))
                  idx (1+ idx)
                  l (cdr l)))
          (aset first-slot 2 msg)))

    ;; Highlight the current conversion.
    (if (> current-idx 0)
        (let ((pos 3)
              (limit (length msg)))
          (remove-text-properties 0 (length msg) '(face nil) msg)
          (while (not (eq (get-text-property pos 'kkh-conversion-index msg)
                          current-idx))
            (setq pos (next-single-property-change pos 'kkh-conversion-index
                                                   msg limit)))
          (put-text-property pos (next-single-property-change
                                  pos 'kkh-conversion-index msg limit)
                             'face 'highlight msg)))
    (let ((message-log-max nil))
      (message "%s" msg))))

;; Update the conversion area with the latest conversion selected.
;; ALL if non-nil means to update the whole area, else update only
;; inside quail-overlay-head.

(defun kkh-update-conversion (&optional all)
  (goto-char (overlay-start kkh-overlay-head))
  (cond ((= (car kkh-current-conversions) 0) ; Hiragana
         (let ((i 0))
           (while (< i kkh-length-converted)
             (insert (aref kkh-current-key i))
             (setq i (1+ i)))))
        ((= (car kkh-current-conversions) -1) ; Katakana
         (let ((i 0))
           (while (< i kkh-length-converted)
             (insert (japanese-katakana (aref kkh-current-key i)))
             (setq i (1+ i)))))
        (t
         (insert (nth (car kkh-current-conversions) kkh-current-conversions))))
  (delete-region (point) (overlay-start kkh-overlay-tail))
  (if all
      (let ((len (length kkh-current-key))
            (i kkh-length-converted))
        (delete-region (overlay-start kkh-overlay-tail)
                       (overlay-end kkh-overlay-head))
        (while (< i kkh-length-head)
          (if (= (car kkh-current-conversions) -1)
              (insert (japanese-katakana (aref kkh-current-key i)))
            (insert (aref kkh-current-key i)))
          (setq i (1+ i)))
        (let ((pos (point)))
          (while (< i len)
            (insert (aref kkh-current-key i))
            (setq i (1+ i)))
          (move-overlay kkh-overlay-head
                        (overlay-start kkh-overlay-head) pos)
          (delete-region (point) (overlay-end kkh-overlay-tail)))))
  (unwind-protect
      (run-hook-with-args 'kkh-after-update-conversion-functions
                          (overlay-start kkh-overlay-head)
                          (overlay-end kkh-overlay-head))
    (goto-char (overlay-end kkh-overlay-tail))))

;;

(defun kkh-conv-hiragana ()
  "ひらがなに確定する."
  (interactive)
  (kkh-hiragana)
  (kkh-next-phrase))

(defun kkh-conv-katakana ()
  "カタカナに確定する."
  (interactive)
  (kkh-katakana)
  (kkh-next-phrase))

;; hankaku/zenkaku

(defun kkh-conv-to-hankaku ()
  "半角カナに変換する."
  (interactive)
  (mapconcat
   #'(lambda (c) (japanese-hankaku (kkh-special (char-to-string c))))
   (string-to-list
    (substring (mapconcat #'(lambda (c) (char-to-string c)) kkh-current-key "")
               0 kkh-length-head))
   ""))

(defun kkh-conv-to-zenkaku ()
  "全角英字に変換する."
  (interactive)
  (mapconcat
   #'(lambda (c)
       (japanese-zenkaku
        (or (car (cl-rassoc (list (char-to-string c)) kkh-rules :test #'equal))
            (char-to-string c))))
   (string-to-list
    (substring (mapconcat #'(lambda (c) (char-to-string c)) kkh-current-key "")
               0 kkh-length-head))
   ""))

(defun kkh-conv-hankaku ()
  "半角カナに確定する."
  (interactive)
  (goto-char (overlay-start kkh-overlay-head))
  (insert (kkh-conv-to-hankaku))
  (delete-region (point) (overlay-end kkh-overlay-head))
  (unwind-protect
      (run-hook-with-args 'kkh-after-update-conversion-functions
                          (overlay-start kkh-overlay-head)
                          (overlay-end kkh-overlay-head))
    (goto-char (overlay-end kkh-overlay-tail))
    (kkh-next-phrase)))

(defun kkh-conv-zenkaku ()
  "全角英字に確定する."
  (interactive)
  (goto-char (overlay-start kkh-overlay-head))
  (insert (kkh-conv-to-zenkaku))
  (delete-region (point) (overlay-end kkh-overlay-head))
  (unwind-protect
      (run-hook-with-args 'kkh-after-update-conversion-functions
                          (overlay-start kkh-overlay-head)
                          (overlay-end kkh-overlay-head))
    (goto-char (overlay-end kkh-overlay-tail))
    (kkh-next-phrase)))

;; ascii

(defun kkh-conv-to-ascii (&optional current-key length-head)
  "ASCII 文字列に変換する."
  (interactive)
  (let* ((kkh-current-key (if current-key current-key kkh-current-key))
         (kkh-length-head (if length-head length-head kkh-length-head)))
    (mapconcat
     #'(lambda (c)
         (or (car (cl-rassoc (list (char-to-string c))
                             kkh-rules :test #'equal))
             (char-to-string c)))
     (string-to-list
      (substring (mapconcat #'(lambda (c) (char-to-string c))
                            kkh-current-key "")
                 0 kkh-length-head))
     "")))

(defun kkh-conv-ascii ()
  "ASCII 文字列に確定する."
  (interactive)
  (goto-char (overlay-start kkh-overlay-head))
  (insert (kkh-conv-to-ascii))
  (delete-region (point) (overlay-end kkh-overlay-head))
  (unwind-protect
      (run-hook-with-args 'kkh-after-update-conversion-functions
                          (overlay-start kkh-overlay-head)
                          (overlay-end kkh-overlay-head))
    (goto-char (overlay-end kkh-overlay-tail))
    (kkh-next-phrase)))

;;; reconvert

(defun kkh-backward-scan-pattern ()
  "再変換の対象となる部分文字列にマッチする正規表現を返す."
  (concat "\\("
          (mapconcat (lambda (s) (regexp-quote s))
                     (mapcar (lambda (rule) (car rule)) kkh-rules)
                     "\\|")
          "\\)+$"))

(defun kkh-backward-scan-ascii (str)
  "STR を末尾から先頭方向にスキャンして, 再変換の対象となる部分文字列を返す
(`kkh-backward-scan-pattern' を参照).
変換すべき文字列がないときは, nil を返す."
  (let ((case-fold-search nil))
    (save-match-data
      (if (string-match (kkh-backward-scan-pattern) str)
          (match-string-no-properties 0 str)
        nil))))

(defun kkh-reconvert ()
  "バッファ内の文字列に対して `kkh-region' を使って再変換を行う.
リージョンがアクティブのときは, そのリージョンを変換する.
そうでなければ, カーソルの左の対象文字列を変換する
(`kkh-backward-scan-ascii' を参照)."
  (interactive)
  (when (equal current-input-method "japanese-kkh")
    (if (use-region-p)
        (kkh-region (region-beginning) (region-end))
      (let* ((str (buffer-substring (point-at-bol) (point)))
             (ascii (kkh-backward-scan-ascii str)))
        (when ascii
          (kkh-region (- (point) (length ascii)) (point)))))))

;;; preview

;; 空白を除く ASCII 文字 [!-~] キーに, quail-self-insert-command を割り当てる
;; (let ((c 33))
;;   (while (< c 127)
;;     ;; (quail-defrule (char-to-string c) (char-to-string c))
;;     (define-key (quail-conversion-keymap)
;;       (char-to-string c) 'quail-self-insert-command)
;;     (setq c (1+ c))))

;;

(defvar kkh-preview-enabled t "非 nil なら, かなプレビューを有効化する.")

;; (defvar kkh-preview-enabled nil
;;   "`echo-area' なら, echo area にかなプレビューを表示する.
;; `popup-tip' なら, popup tip でかなプレビューを表示する.
;; nil なら, かなプレビューを無効化する.")

;; (defface kkh-preview-face
;;   '((t (:inherit popup-tip-face
;;                  :weight normal :slant normal
;;                  :underline nil :inverse-video nil)))
;;   "かなプレビューのポップアップのフェイス.")

;; (defvar kkh-preview-popup nil "ポップアップオブジェクト.")

;; (defun kkh-preview-hide ()
;;   "かなプレビューを非表示にする."
;;   ;;
;;   ;; (when (and (featurep 'popup)
;;   (when (and (eq kkh-preview-enabled 'popup-tip)
;;              (featurep 'popup)
;;              ;; /
;;              (popup-live-p kkh-preview-popup))
;;     (popup-delete kkh-preview-popup)))

;; (defun kkh-preview-show (&rest _arguments)
;;   "`kkh-preview-enabled' が非 nil なら, かなプレビューを表示する."
;;   (when (equal current-input-method "japanese-kkh")
;;     (let* ((beg (overlay-start quail-conv-overlay))
;;            (end (overlay-end quail-conv-overlay))
;;            (str (and beg end (buffer-substring beg end))))
;;       (kkh-preview-hide)
;;       (when str
;;         (setq quail-conversion-str str)
;;         (setq quail-current-str nil
;;               quail-current-key nil)
;;         ;;
;;         (when (eq kkh-preview-enabled 'echo-area)
;;           (let ((message-log-max nil))
;;             (message "%s" (kkh-to-kana str))))
;;         ;; (when (and (featurep 'popup)
;;         (when (and (eq kkh-preview-enabled 'popup-tip)
;;                    (featurep 'popup)
;;                    ;; /
;;                    kkh-preview-enabled)
;;           (kkh-preview-hide)
;;           (setq kkh-preview-popup (popup-tip (kkh-to-kana str)
;;                                               :face 'kkh-preview-face
;;                                               :height 1 :nowait t)))))))

;; (defun kkh-preview-show (&rest _arguments)
;;   "`kkh-preview-enabled' が非 nil なら, かなプレビューを表示する."
;;   (when (and (equal current-input-method "japanese-kkh")
;;              (overlayp quail-conv-overlay))
;;     (let* ((beg (overlay-start quail-conv-overlay))
;;            (end (overlay-end quail-conv-overlay))
;;            (str (and beg end (buffer-substring beg end))))
;;       (message nil)
;;       (when str
;;         (setq quail-conversion-str str)
;;         (setq quail-current-str nil
;;               quail-current-key nil)
;;         (when kkh-preview-enabled
;;           (let ((message-log-max nil))
;;             (message "%s" (kkh-to-kana str))))))))

;; mini-buffer 内でもかなプレビューできるこちらのほうがいいかも
(defun kkh-preview-set-guidance-str ()
  "`kkh-preview-enabled' が非 nil なら, `quail-guidance-str' を設定する."
  (when (and (equal current-input-method "japanese-kkh")
             (overlayp quail-conv-overlay))
    (let* ((beg (overlay-start quail-conv-overlay))
           (end (overlay-end quail-conv-overlay))
           (str (and beg end (buffer-substring-no-properties beg end))))
      (when str
        (setq quail-conversion-str str
              ;; quail-current-key nil
              ;; quail-current-str nil
              quail-guidance-str (if kkh-preview-enabled
                                     (kkh-to-kana str)
                                   ""))))))

;;

;; かなプレビューを表示・非表示するアドバイスとフック
;; (dolist (fun '(quail-conversion-backward-delete-char
;;                quail-conversion-delete-char
;;                quail-self-insert-command
;;                kkh-translit-convert))
;;   (advice-add fun :after #'kkh-preview-show))

;; (advice-add 'kkh-translit-cancel :after #'kkh-preview-hide)
;; (advice-add 'kkh-translit-convert :before #'kkh-preview-hide)

;; (add-hook 'post-command-hook #'kkh-preview-hide)

;; (advice-add 'quail-show-guidance :after #'kkh-preview-show)

(advice-add 'quail-show-guidance :before #'kkh-preview-set-guidance-str)

;;

(defun kkh-preview-toggle ()
  "かなプレビューをトグルする."
  (interactive)
  (when (equal current-input-method "japanese-kkh")
    (setq kkh-preview-enabled (not kkh-preview-enabled))
    (message "Kana preview %s" (if kkh-preview-enabled "on" "off"))
    ;; (kkh-preview-show))
    (kkh-preview-set-guidance-str)))

;;; reinput

(defvar kkh-reinput-original-ascii nil "入力の ASCII 文字列.")

(defun kkh-reinput-set-original-ascii ()
  "`kkh-reinput-original-ascii' を設定する."
  (when (and (equal current-input-method "japanese-kkh")
             (overlayp quail-conv-overlay))
    (let* ((beg (overlay-start quail-conv-overlay))
           (end (overlay-end quail-conv-overlay))
           (str (and beg end (buffer-substring-no-properties beg end))))
      (setq kkh-reinput-original-ascii str))))

(defun kkh-reinput ()
  "`kkh-reinput-original-ascii' を再入力する."
  (interactive)
  (when (and (equal current-input-method "japanese-kkh")
             kkh-reinput-original-ascii)
    (setq unread-input-method-events
          ;; (string-to-list kkh-reinput-original-ascii)
          ;; XXX: S-SPC で入力した空白を処理したい
          (mapcar (lambda (c) (if (eq c ?\ )
                                  ?\S-\ ; XXX: ここ
                                c))
                  (string-to-list kkh-reinput-original-ascii)))))

(advice-add 'quail-show-guidance :before #'kkh-reinput-set-original-ascii)

;;; deactivate input method all buffers

(defun kkh-deactivate-input-method-all-buffers (verbose)
  "すべてのバッファでインプットメソッドを OFF にする."
  (interactive "p")
  (let ((count 0))
    (save-window-excursion
      (dolist (buffer (buffer-list))
        (with-current-buffer buffer
          (when current-input-method
            (deactivate-input-method)
            (when verbose (message "Deactivated input method in buffer %s"
                                   (buffer-name buffer)))
            (setq count (1+ count)))))
      (when verbose
        (message "(Deactivated input method in %d buffer(s))" count)))))

;;; set layout & input method title

(defun kkh-set-layout-ad (&rest _args)
  (when (and (equal current-input-method "japanese-kkh")
             (null kkh-current-layout))
    (let ((layout (assoc kkh-default-layout-name kkh-layouts)))
      (when layout
        (kkh-set-layout layout)))))

(defun kkh-input-method-title-ad (&rest _args)
  "`current-input-method-title' にかな入力配列名を付加する."
  (when (equal current-input-method "japanese-kkh")
    (let* ((title (nth 1 kkh-current-layout))
           (title (format "%s(%s)" (quail-title) title)))
      (setq current-input-method-title title))))

;; > 同じdepthで2つのアドバイスが指定された場合には、
;; > もっとも最近に追加されたアドバイスが最外になります。
;;
;; > 同様に:afterアドバイスにたいしては、最内とは元の関数の直後、
;; > つまりこの元の関数とアドバイスの間に実行される他のアドバイスは存在せず、
;; > 最外とは他のすべてのアドバイスが実行された直後にこのアドバイスが
;; > 実行されることを意味する。
(advice-add 'activate-input-method :after #'kkh-set-layout-ad)
(advice-add 'activate-input-method :after #'kkh-input-method-title-ad)
(advice-add 'kkh-select-layout :after #'kkh-input-method-title-ad)

;;; cursor color

(defvar kkh-cursor-color nil
  "日本語モードのときのカーソル色を表す文字列.
nil なら, カーソル色を変更しない.")

(defvar kkh-cursor-color-default
  (cdr (assq 'cursor-color (frame-parameters (selected-frame))))
  "日本語モードでないときのカーソル色を表す文字列.")

(defun kkh-cursor-color-set-color ()
  "日本語モードのときにカーソル色を `kkh-cursor-color' に変更する."
  (cond ((null kkh-cursor-color) nil)
        ((and kkh-cursor-color (equal current-input-method "japanese-kkh"))
         (set-cursor-color kkh-cursor-color))
        (t (set-cursor-color kkh-cursor-color-default))))

;; (add-hook 'post-command-hook 'kkh-cursor-color-set-color)

;; provide

(provide 'kkh)
;;; kkh.el ends here
