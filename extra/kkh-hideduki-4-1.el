;;; kkh-hideduki-4-1.el --- Hideduki v4.1 for kkh.el  -*- lexical-binding: t; -*-

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

;; - https://web.archive.org/web/20220125140149/https://twitter.com/madeinwariofan/status/1147041872583331842
;; - https://drive.google.com/file/d/1JhB-7VCcWZcJtbrA9fdnX0vV9BbqjSIs/view
;; - https://drive.google.com/file/d/1s74K4jWwTfG2SH8uvp7aQ7E81Di2Xf9B/view

;;; Code:

(require 'kkh)

(kkh-define-layout
 '("hideduki-4-1"
   "英月"
   "英月配列 v4.1

# 通常レイヤー            # 濁音レイヤー
そきしては  をんいるー    ぞぎじでば  べぶぜ‐‐
すか★とた  くう☆△‐    ずが‐どだ  ぐヴ‐‐‐
ちこになさ  のり、。・    ぢごげぼざ  びづ‐‐‐

# 異手レイヤー            # 同手レイヤー
ゐおみえめ  へふせゆぬ    ‐ぉ‐ぇぱ  ぺぷぃゅ‐
ねれらあわ  やまもよ‐    ‐ヵ‐ぁゎ  ゃぅ‐ょ‐
ゑろけほむ  ひつ‐‐‐    ‐‐ヶぽ‐  ぴっ‐‐‐
"
   (;; ( "~" "〜")
    ( "." "。") ( "," "、") ( "/" "・")
    ;; ("d/" "・") ("d;" "；") ("d." "…")  ("d," "‥") ("k/" "／")
    ;; ("ddh" "←") ("ddj" "↓") ("ddk" "↑") ("ddl" "→") ("d-" "〜")
    ( "[" "「") ( "]" "」")
    ;; ("ld" "「") ("lk" "」") ("d[" "『") ("d]" "』")
    ("kf" "あ") ( "i" "い") ( "j" "う") ("kr" "え") ("kw" "お")
    ( "s" "か") ( "w" "き") ( "h" "く") ("kc" "け") ( "x" "こ")
    ( "b" "さ") ( "e" "し") ( "a" "す") ("di" "せ") ( "q" "そ")
    ( "g" "た") ( "z" "ち") ("dm" "つ") ( "r" "て") ( "f" "と")
    ( "v" "な") ( "c" "に") ("dp" "ぬ") ("ka" "ね") ( "n" "の")
    ( "t" "は") ("dn" "ひ") ("du" "ふ") ("dy" "へ") ("kv" "ほ")
    ("dj" "ま") ("ke" "み") ("kb" "む") ("kt" "め") ("dk" "も")
    ("dh" "や") ("do" "ゆ") ("dl" "よ")
    ("kd" "ら") ( "m" "り") ( "o" "る") ("ks" "れ") ("kx" "ろ")
    ("kg" "わ") ("kq" "ゐ") ("kz" "ゑ") ( "y" "を") ( "u" "ん")
    ( "p" "ー")
    ("df" "ぁ") ("ki" "ぃ") ("kj" "ぅ") ("dr" "ぇ") ("dw" "ぉ")
    ("km" "っ") ("kh" "ゃ") ("ko" "ゅ") ("kl" "ょ")
    ("dg" "ゎ") ("ds" "ヵ") ("dc" "ヶ") ("lj" "ヴ") ;; ("lj" "ゔ")
    ("ls" "が") ("lw" "ぎ") ("lh" "ぐ") ("lc" "げ") ("lx" "ご")
    ("lb" "ざ") ("le" "じ") ("la" "ず") ("li" "ぜ") ("lq" "ぞ")
    ("lg" "だ") ("lz" "ぢ") ("lm" "づ") ("lr" "で") ("lf" "ど")
    ("lt" "ば") ("ln" "び") ("lu" "ぶ") ("ly" "べ") ("lv" "ぼ")
    ("dt" "ぱ") ("kn" "ぴ") ("ku" "ぷ") ("ky" "ぺ") ("dv" "ぽ")
    ;; ("lo" "゛") ("de" "゜")
    )))

(provide 'kkh-hideduki-4-1)
;;; kkh-hideduki-4-1.el ends here
