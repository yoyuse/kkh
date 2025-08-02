;;; kkh-moon-2-263-us.el --- Tsuki layout 2-263 US for kkh.el  -*- lexical-binding: t; -*-

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

;; - 「月」 --- 中指シフト新JIS配列
;; - https://jisx6004.client.jp/tsuki.html

;;; Code:

(require 'kkh)

(kkh-define-layout
 '("moon-2-263-us"
   "月2-263-US"
   "中指前置シフト新JIS 月配列 2-263 USキーボード用

# 単打
そこしてょ  つんいのり  ち・
はか☆とた  くう★゛き  れ
すけになさ  っる、。゜

# 逆手シフト
ぁひほふめ  ぬえみやぇ  「」
ぃをらあよ  まおもわゆ
ぅへせゅゃ  むろねーぉ
"

   (( "q" "そ") ( "w" "こ") ( "e" "し") ( "r" "て") ( "t" "ょ")
    ( "y" "つ") ( "u" "ん") ( "i" "い") ( "o" "の") ( "p" "り")
    ( "a" "は") ( "s" "か") ( "d" "☆") ( "f" "と") ( "g" "た")
    ( "h" "く") ( "j" "う") ( "k" "★") ( "l" "゛") ( ";" "き")
    ( "z" "す") ( "x" "け") ( "c" "に") ( "v" "な") ( "b" "さ")
    ( "n" "っ") ( "m" "る") ( "," "、") ( "." "。") ( "/" "゜")
    ( "[" "ち") ( "]" "・")
    ( "'" "れ")

    ("kq" "ぁ") ("kw" "ひ") ("ke" "ほ") ("kr" "ふ") ("kt" "め")
    ("ka" "ぃ") ("ks" "を") ("kd" "ら") ("kf" "あ") ("kg" "よ")
    ("kz" "ぅ") ("kx" "へ") ("kc" "せ") ("kv" "ゅ") ("kb" "ゃ")

    ("dy" "ぬ") ("du" "え") ("di" "み") ("do" "や") ("dp" "ぇ")
    ("dh" "ま") ("dj" "お") ("dk" "も") ("dl" "わ") ("d;" "ゆ")
    ("dn" "む") ("dm" "ろ") ("d," "ね") ("d." "ー") ("d/" "ぉ")
    ("d[" "「") ("d]" "」")

    ("ql" "ぞ") ("wl" "ご") ("el" "じ") ("rl" "で")
    ("yl" "づ")
    ("al" "ば") ("sl" "が")             ("fl" "ど") ("gl" "だ")
    ("hl" "ぐ") ("jl" "ヴ")                         (";l" "ぎ")
    ("zl" "ず") ("xl" "げ")                         ("bl" "ざ")
    ("[l" "ぢ")
    ("a/" "ぱ")

                 ("kwl" "び") ("kel" "ぼ") ("krl" "ぶ")
                 ("kxl" "べ") ("kcl" "ぜ")
                 ("kw/" "ぴ") ("ke/" "ぽ") ("kr/" "ぷ")
                 ("kx/" "ぺ")

    ;; ゎゐゑヵヶ を わいえかけ の半濁音として定義
    ("dl/" "ゎ") ( "i/" "ゐ") ("du/" "ゑ")
    ( "s/" "ヵ") ( "x/" "ヶ")
    )))

(provide 'kkh-moon-2-263-us)
;;; kkh-moon-2-263-us.el ends here
