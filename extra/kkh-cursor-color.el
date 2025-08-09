;;; kkh-cursor-color.el --- Change Cursor Color for kkh.el  -*- lexical-binding: t; -*-

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

;;; Setup:

;; (when (require 'kkh nil t)
;;   (require 'kkh-cursor-color)
;;   ;; カーソル色を Teal 400 に
;;   (setq kkh-cursor-color "#26A69A")
;;   )

;;; Code:

(require 'kkh)

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

(add-hook 'post-command-hook 'kkh-cursor-color-set-color)
;; (remove-hook 'post-command-hook 'kkh-cursor-color-set-color)

(provide 'kkh-cursor-color)
;;; kkh-cursor-color.el ends here
