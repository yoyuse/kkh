;;; kkh-romann.el --- Roman (double n) input for kkh.el  -*- lexical-binding: t; -*-

;; Copyright (C) 2025  YUSE Yosihiro

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

;; ん を nn で入力する (setq quail-japanese-use-double-n t) 相当のローマ字入力

;;; Code:

(require 'kkh)

(kkh-define-layout
 '("romann"
   "RomaNN"
   "ローマ字入力 (double n)"

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
    ("xn" "ん") ("nn" "ん")              ; double n
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

(provide 'kkh-romann)
;;; kkh-romann.el ends here
