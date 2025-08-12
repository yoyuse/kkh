;;; kkh-moon-cx.el --- Tsuki layout Cx for kkh.el    -*- lexical-binding: t; -*-

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

;; ** 月配列 Cx
;; - ベースは 月配列 2-263
;; - 同手シフトも使う
;; - 30 キーの範囲に収める
;; - 濁音・半濁音 (ぜびぶべぼぴぷぺぽ) を 2 打鍵化

;;; Code:

(require 'kkh)

(kkh-define-layout
 '("moon-cx"
   "月Cx"
   "中指前置シフト新JIS 月配列 私家版 C4

# 単打
そこしてょ  つんいのり
はか★とた  くう★゛き
すけになさ  っる、。ー

# ★逆手シフト            # ★同手シフト
ぁひほふめ  ぬえみやぇ    ば  び  ぼ  ぶ  べ      ちぇてぃでぃぢ  ち
ぃをらあよ  まおもわゆ    ふぁふぃ◎  ふぉふぇ    ゑ  ゐ  ◎  ゎ  れ
ぅへせゅゃ  むろね゜ぉ    ぱ  ぴ  ぽ  ぷ  ぺ      ヵ  ヶ  「  」  ・

# 特殊
ぜ(cl)

# ◎逆手シフト            # ◎同手シフト
℃≪≦〇〒  ￥∞≧≫≠    【《〈“‘  ’”〉》】
☆△□○×  ←↓↑→≒    ★▲■●§  仝々〃⇒⇔
　▽◇◎◯  ♪〜—…≡    〓▼◆※¶  ±÷『』〆
"

   (( "q" "そ") ( "w" "こ") ( "e" "し") ( "r" "て") ( "t" "ょ")
    ( "y" "つ") ( "u" "ん") ( "i" "い") ( "o" "の") ( "p" "り")
    ( "a" "は") ( "s" "か")             ( "f" "と") ( "g" "た")
    ( "h" "く") ( "j" "う")             ( "l" "゛") ( ";" "き")
    ( "z" "す") ( "x" "け") ( "c" "に") ( "v" "な") ( "b" "さ")
    ( "n" "っ") ( "m" "る") ( "," "、") ( "." "。") ( "/" "ー")

    ("dq" "ば") ("dw" "び") ("de" "ぼ") ("dr" "ぶ") ("dt" "べ")
    ("dy" "ぬ") ("du" "え") ("di" "み") ("do" "や") ("dp" "ぇ")
    ("da" "ふぁ") ("ds" "ふぃ")     ("df" "ふぉ") ("dg" "ふぇ")
    ("dh" "ま") ("dj" "お") ("dk" "も") ("dl" "わ") ("d;" "ゆ")
    ("dz" "ぱ") ("dx" "ぴ") ("dc" "ぽ") ("dv" "ぷ") ("db" "ぺ")
    ("dn" "む") ("dm" "ろ") ("d," "ね") ("d." "゜") ("d/" "ぉ")

    ("kq" "ぁ") ("kw" "ひ") ("ke" "ほ") ("kr" "ふ") ("kt" "め")
    ("ky" "ちぇ") ("ku" "てぃ") ("ki" "でぃ") ("ko" "ぢ") ("kp" "ち")
    ("ka" "ぃ") ("ks" "を") ("kd" "ら") ("kf" "あ") ("kg" "よ")
    ("kh" "ゑ") ("kj" "ゐ")             ("kl" "ゎ") ("k;" "れ")
    ("kz" "ぅ") ("kx" "へ") ("kc" "せ") ("kv" "ゅ") ("kb" "ゃ")
    ("kn" "ヵ") ("km" "ヶ") ("k," "「") ("k." "」") ("k/" "・")

    ("ql" "ぞ") ("wl" "ご") ("el" "じ") ("rl" "で")
    ("yl" "づ")
                ("sl" "が")             ("fl" "ど") ("gl" "だ")
    ("hl" "ぐ") ("jl" "ヴ")                         (";l" "ぎ")
    ("zl" "ず") ("xl" "げ") ("cl" "ぜ")             ("bl" "ざ")

    ("kcl" "ぜ")
    ( "al" "ば") ( "kwl" "び") ( "krl" "ぶ") ( "kxl" "べ") ( "kel" "ぼ")
    ("ad." "ぱ") ("kwd." "ぴ") ("krd." "ぷ") ("kxd." "ぺ") ("ked." "ぽ")

    ("ddq" "【") ("ddw" "《") ("dde" "〈") ("ddr" "“") ("ddt" "‘")
    ("ddy" "￥") ("ddu" "∞") ("ddi" "≧") ("ddo" "≫") ("ddp" "≠")
    ("dda" "★") ("dds" "▲") ("ddd" "■") ("ddf" "●") ("ddg" "§")
    ("ddh" "←") ("ddj" "↓") ("ddk" "↑") ("ddl" "→") ("dd;" "≒")
    ("ddz" "〓") ("ddx" "▼") ("ddc" "◆") ("ddv" "※") ("ddb" "¶")
    ("ddn" "♪") ("ddm" "〜") ("dd," "—") ("dd." "…") ("dd/" "≡")

    ("kkq" "℃") ("kkw" "≪") ("kke" "≦") ("kkr" "〇") ("kkt" "〒")
    ("kky" "’") ("kku" "”") ("kki" "〉") ("kko" "》") ("kkp" "】")
    ("kka" "☆") ("kks" "△") ("kkd" "□") ("kkf" "○") ("kkg" "×")
    ("kkh" "仝") ("kkj" "々") ("kkk" "〃") ("kkl" "⇒") ("kk;" "⇔")
    ("kkz" "　") ("kkx" "▽") ("kkc" "◇") ("kkv" "◎") ("kkb" "◯")
    ("kkn" "±") ("kkm" "÷") ("kk," "『") ("kk." "』") ("kk/" "〆")
    )))

(provide 'kkh-moon-cx)
;;; kkh-moon-cx.el ends here
