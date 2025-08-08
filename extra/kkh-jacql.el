;;; kkh-jacql.el --- Jacql Typing for kkh.el         -*- lexical-binding: t; -*-

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

;; - Jacql Typing - ジャックル打鍵法
;; - http://jgrammar.life.coocan.jp/ja/tools/imekeys.htm#Jacql

;;; Code:

(require 'kkh)

(kkh-define-layout
 '("jacql"
   "Jacql"
   "Jacql Typing"

   (( "a" "あ") ( "i" "い") ( "u" "う") ( "e" "え") ( "o" "お")
    ("ka" "か") ("ki" "き") ("ku" "く") ("ke" "け") ("ko" "こ")
    ("sa" "さ") ("si" "し") ("su" "す") ("se" "せ") ("so" "そ")
    ("ta" "た") ("ti" "ち") ("tu" "つ") ("te" "て") ("to" "と")
    ("na" "な") ("ni" "に") ("nu" "ぬ") ("ne" "ね") ("no" "の")
    ("ha" "は") ("hi" "ひ") ("hu" "ふ") ("he" "へ") ("ho" "ほ")
    ("ma" "ま") ("mi" "み") ("mu" "む") ("me" "め") ("mo" "も")
    ("ya" "や")           ("yu" "ゆ") ("ye" "いぇ") ("yo" "よ")
    ("ra" "ら") ("ri" "り") ("ru" "る") ("re" "れ") ("ro" "ろ")
    ("wa" "わ") ("wi" "うぃ")         ("we" "うぇ") ("wo" "を")
    ("nn" "ん")
    ("ga" "が") ("gi" "ぎ") ("gu" "ぐ") ("ge" "げ") ("go" "ご")
    ("za" "ざ") ("zi" "じ") ("zu" "ず") ("ze" "ぜ") ("zo" "ぞ")
    ("da" "だ") ("di" "ぢ") ("du" "づ") ("de" "で") ("do" "ど")
    ("ba" "ば") ("bi" "び") ("bu" "ぶ") ("be" "べ") ("bo" "ぼ")
    ("pa" "ぱ") ("pi" "ぴ") ("pu" "ぷ") ("pe" "ぺ") ("po" "ぽ")

    ("kya" "きゃ") ("kyu" "きゅ") ("kye" "きぇ") ("kyo" "きょ")
    ("sya" "しゃ") ("syu" "しゅ") ("sye" "しぇ") ("syo" "しょ")
    ("tya" "ちゃ") ("tyu" "ちゅ") ("tye" "ちぇ") ("tyo" "ちょ")
    ("nya" "にゃ") ("nyu" "にゅ") ("nye" "にぇ") ("nyo" "にょ")
    ("hya" "ひゃ") ("hyu" "ひゅ") ("hye" "ひぇ") ("hyo" "ひょ")
    ("mya" "みゃ") ("myu" "みゅ") ("mye" "みぇ") ("myo" "みょ")
    ("rya" "りゃ") ("ryu" "りゅ") ("rye" "りぇ") ("ryo" "りょ")
    ("gya" "ぎゃ") ("gyu" "ぎゅ") ("gye" "ぎぇ") ("gyo" "ぎょ")
    ("zya" "じゃ") ("zyu" "じゅ") ("zye" "じぇ") ("zyo" "じょ")
    ("dya" "ぢゃ") ("dyu" "ぢゅ")                ("dyo" "ぢょ")
    ("bya" "びゃ") ("byu" "びゅ") ("bye" "びぇ") ("byo" "びょ")
    ("pya" "ぴゃ") ("pyu" "ぴゅ") ("pye" "ぴぇ") ("pyo" "ぴょ")

    ( "xa" "ぁ") ( "xi" "ぃ") ( "xu" "ぅ") ( "xe" "ぇ") ( "xo" "ぉ")
    ("xtu" "っ") ("xya" "ゃ") ("xyu" "ゅ") ("xyo" "ょ") ("xwa" "ゎ")
    ("xka" "ヵ") ("xke" "ヶ") ( "xb" "゛") ( "xp" "゜")

    ("whi" "うぃ") ("whe" "うぇ") ("who" "うぉ")
    ( "va" "ヴぁ") ( "vi" "ヴぃ") ( "vu" "ヴ") ( "ve" "ヴぇ") ( "vo" "ヴぉ")
    ("vya" "ヴゃ")                ("vyu" "ヴゅ")              ("vyo" "ヴょ")

    ("kwa" "くぁ") ("kwi" "くぃ") ("kwe" "くぇ") ("kwo" "くぉ")
    ("gwa" "ぐぁ") ("gwi" "ぐぃ") ("gwe" "ぐぇ") ("gwo" "ぐぉ")

    ("swi" "すぃ")
    ("zwi" "ずぃ")

    ("twu" "とぅ")
    ("dwu" "どぅ")

    ("tha" "てゃ") ("thi" "てぃ") ("thu" "てゅ") ("tho" "てょ")
    ("dha" "でゃ") ("dhi" "でぃ") ("dhu" "でゅ") ("dho" "でょ")

    ("sha" "しゃ") ("shi" "し") ("shu" "しゅ") ("she" "しぇ") ("sho" "しょ")
    ("tsa" "つぁ") ("tsi" "つぃ") ("tsu" "つ") ("tse" "つぇ") ("tso" "つぉ")

    ("fa" "ふぁ") ("fi" "ふぃ") ("fu" "ふ") ("fe" "ふぇ") ("fo" "ふぉ")
    ("fya" "ふゃ") ("fyu" "ふゅ") ("fyo" "ふょ")

    ("wyi" "ゐ") ("wye" "ゑ")

    ("q" "か") ("j" "く") ("c" "け") ("l" "こ")
    ("kkq" "っか") ("kkj" "っく") ("kkc" "っけ") ("kkl" "っこ")
    ("kkkq" "っきゃ") ("kkkj" "っきゅ") ("kkkl" "っきょ")
    ("kkkv" "っかい") ("kkkc" "っけい") ("kkkf" "っこう")

    ("kv" "かい") ("kc" "けい") ("kf" "こう")
    ("sv" "さい") ("sc" "せい") ("sf" "そう")
    ("tv" "たい") ("tc" "てい") ("tf" "とう")
    ("nv" "ない") ("nc" "ねい") ("nf" "のう")
    ("hv" "はい") ("hc" "へい") ("hf" "ほう")
    ("mv" "まい") ("mc" "めい") ("mf" "もう")
    ("yv" "やい")               ("yf" "よう")
    ("rv" "らい") ("rc" "れい") ("rf" "ろう")
    ("wv" "わい") ("wyc" "ゑい") ("wf" "をう")
    ("gv" "がい") ("gc" "げい") ("gf" "ごう")
    ("zv" "ざい") ("zc" "ぜい") ("zf" "ぞう")
    ("dv" "だい") ("dc" "でい") ("df" "どう")
    ("bv" "ばい") ("bc" "べい") ("bf" "ぼう")
    ("pv" "ぱい") ("pc" "ぺい") ("pf" "ぽう")

    ("xq" "ゃ")   ("xj" "ゅ")   ("xl" "ょ")

    ("kq" "きゃ") ("kj" "きゅ") ("kl" "きょ")
    ("sq" "しゃ") ("sj" "しゅ") ("sl" "しょ")
    ("tq" "ちゃ") ("tj" "ちゅ") ("tl" "ちょ")
    ("nq" "にゃ") ("nj" "にゅ") ("nl" "にょ")
    ("hq" "ひゃ") ("hj" "ひゅ") ("hl" "ひょ")
    ("mq" "みゃ") ("mj" "みゅ") ("ml" "みょ")
    ("rq" "りゃ") ("rj" "りゅ") ("rl" "りょ")
    ("gq" "ぎゃ") ("gj" "ぎゅ") ("gl" "ぎょ")
    ("zq" "じゃ") ("zj" "じゅ") ("zl" "じょ")
    ("dq" "ぢゃ") ("dj" "ぢゅ") ("dl" "ぢょ")
    ("bq" "びゃ") ("bj" "びゅ") ("bl" "びょ")
    ("pq" "ぴゃ") ("pj" "ぴゅ") ("pl" "ぴょ")
    ("fq" "ふゃ") ("fj" "ふゅ") ("fl" "ふょ")
    ("vq" "ヴゃ") ("vj" "ヴゅ") ("vl" "ヴょ")

    ;;

    ("n" "ん")
    ("bb" "っb") ("dd" "っd") ("ff" "っf") ("gg" "っg")
    ("hh" "っh") ("kk" "っk") ("mm" "っm")
    ("pp" "っp") ("rr" "っr") ("ss" "っs") ("tt" "っt")
    ("vv" "っv") ("ww" "っw") ("xx" "っx") ("yy" "っy") ("zz" "っz")

    ( "-" "ー") ( "[" "「") ( "]" "」") ( "," "、") ( "." "。")
    ( "/" "・")

    ;; ("z-" "〜") ("z[" "『") ("z]" "』") ("z," "‥") ("z." "…") ("z/" "・")
    ;; ("z1" "○") ("z2" "▽") ("z3" "△") ("z4" "□") ("z5" "◇") ("z6" "☆")
    ;; ("z!" "●") ("z@" "▼") ("z#" "▲") ("z$" "■") ("z%" "◆") ("z^" "★")
    ;; ("z7" "◎") ("z*" "×") ("z(" "【") ("z)" "】") ("z{" "〔") ("z}" "〕")
    ;; ("zB" "←") ("zN" "↓") ("zP" "↑") ("zF" "→")
    ;; ("zG" "—") ("zM" "〓") ("zY" "￥") ("zC" "℃")
    )))

(provide 'kkh-jacql)
;;; kkh-jacql.el ends here
