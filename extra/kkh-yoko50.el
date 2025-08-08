;;; kkh-yoko50.el --- Yoko50 layout for kkh.el       -*- lexical-binding: t; -*-

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

;; - 横五十音配列 (横50音配列)
;; - http://jgrammar.life.coocan.jp/ja/tools/imekeys.htm#Yoko50

;;; Code:

(require 'kkh)

(kkh-define-layout
 '("yoko50"
   "横50"
   "横五十音配列"

   (( "y" "あ") ( "i" "い") ( "u" "う") ( "p" "え") ( "o" "お")
    ( "q" "か") ( "w" "き") ( "t" "く") ( "e" "け") ( "r" "こ")
    ( "a" "さ") ( "s" "し") ( "g" "す") ("dd" "せ") ( "f" "そ")
    ( "z" "た") ( "x" "ち") ( "b" "つ") ( "c" "て") ( "v" "と")
    ("kq" "な") ("kw" "に") ("kt" "ぬ") ("ke" "ね") ("kr" "の")
    ("ka" "は") ("ks" "ひ") ("kg" "ふ") ("kd" "へ") ("kf" "ほ")
    ("kz" "ま") ("kx" "み") ("kb" "む") ("kc" "め") ("kv" "も")
    ("dh" "や")             ("dj" "ゆ")             ("dl" "よ")
    ("dy" "ら") ("di" "り") ("du" "る") ("dp" "れ") ("do" "ろ")
    ("dn" "わ") ("ds" "ゐ")             ("da" "ゑ") ( "h" "を")
    ( "n" "ん")
    ("qm" "が") ("wm" "ぎ") ("tm" "ぐ") ("em" "げ") ("rm" "ご")
    ("am" "ざ") ("sm" "じ") ("gm" "ず") ("ddm" "ぜ") ("fm" "ぞ")
    ("zm" "だ") ("xm" "ぢ") ("bm" "づ") ("cm" "で") ("vm" "ど")
    ("dq" "ば") ("dw" "び") ("dt" "ぶ") ("de" "べ") ("dr" "ぼ")
    ("dz" "ぱ") ("dx" "ぴ") ("db" "ぷ") ("dc" "ぺ") ("dv" "ぽ")
    ("ky" "ぁ") ("ki" "ぃ") ("ku" "ぅ") ("kp" "ぇ") ("ko" "ぉ")
    ( "j" "っ") ("kh" "ゃ") ("kj" "ゅ") ( "l" "ょ") ("kn" "ゎ")
    ("um" "ヴ") ("qkm" "ヵ") ("ekm" "ヶ")
    ("dm" "ー") ( "," "、") ( "." "。")
    ( "m" "゛") ("km" "゜")
    ( "[" "「") ( "]" "」") ( "/" "・")

    ;; ("d/" "・")
    ;; ("d," "「") ("d." "」") ("k," "『") ("k." "』") ;; ("k/" "/")

    ;; ("k/q" "○") ("k//q" "●")
    ;; ("k/w" "▽") ("k//w" "▼")
    ;; ("k/e" "△") ("k//e" "▲")
    ;; ("k/r" "□") ("k//r" "■")
    ;; ("k/t" "◇") ("k//t" "◆")
    ;; ("k/y" "☆") ("k//y" "★")
    ;; ("k/u" "◎") ("k//u" "£")
    ;; ("k/i" "¢") ("k//i" "×")
    ;; ("k/o" "≠") ("k//o" "±")
    ;; ("k/p" "〒") ("k//p" "∞")
    ;; ("k/a" "々") ("k//a" "仝")
    ;; ("k/s" "ヽ") ("k//s" "ヾ")
    ;; ("k/d" "ゝ") ("k//d" "ゞ")
    ;; ("k/f" "〃") ("k//f" "￥")
    ;; ("k/g" "‐") ("k//g" "—")
    ;; ("k/h" "←") ("k//h" "‘")
    ;; ("k/j" "↓") ("k//j" "’")
    ;; ("k/k" "↑") ("k//k" "“")
    ;; ("k/l" "→") ("k//l" "”")
    ;; ("k/;" "＼") ("k//;" "‖")
    ;; ("k/z" "《") ("k//z" "〈")
    ;; ("k/x" "》") ("k//x" "〉")
    ;; ("k/c" "〇") ("k//c" "℃")
    ;; ("k/v" "※") ("k//v" "÷")
    ;; ("k/b" "〆") ("k//b" "§")
    ;; ("k/n" "〜") ("k//n" "∴")
    ;; ("k/m" "　") ("k//m" "〓")
    ;; ("k/," "‥") ("k//," "【")
    ;; ("k/." "…") ("k//." "】")
    )))

(provide 'kkh-yoko50)
;;; kkh-yoko50.el ends here
