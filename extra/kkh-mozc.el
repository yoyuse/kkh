;;; kkh-mozc.el --- Use Mozc for kkh.el              -*- lexical-binding: t; -*-

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

;; ** 概要
;; - kkh.el から Mozc の変換候補を取得して利用する (実験的機能)
;;
;; ** 使用法
;; - 変換中状態で C-z で Mozc 利用 ON/OFF をトグル (デフォルトは OFF)
;; - Mozc 利用時は C-s でサジェスト ON/OFF をトグル (デフオルトは OFF)
;;
;; ** 制限事項
;; - 変換の学習はしない
;; - 入力履歴も触らない
;; - サジェストなどを利用するには, あらかじめ Google 日本語入力や
;;   japanese-mozc, japanese-mozc-im などで入力し学習させておく必要がある

;;; Code:

(require 'mozc)

(defvar kkh-mozc-enabled nil
  "非 nil のとき, `kkh-lookup-key-sub' の代わりに `kkh-mozc-lookup-key' を使う.")

(defvar kkh-mozc-with-suggest nil
  "非 nil のとき, 変換候補にサジェストを含める.")

;; cf.
;; - ac-mozc/ac-mozc.el at master · igjit/ac-mozc
;; - https://github.com/igjit/ac-mozc/blob/master/ac-mozc.el
(defun kkh-mozc-lookup-key (key len &optional postfix prefer-noun)
  "かなの配列 KEY の長さ LEN 分の変換候補のリストを返す.
POSTFIX と PREFER-NOUN は無視される."
  (let* ((string (concat key))
         (string (substring string 0 len))
         converted suggested)
    (mozc-clean-up-session)
    (mozc-session-sendkey (list string))
    (setq converted
          (mapcar (lambda (c) (cdr (assoc 'value c)))
                  (cdr (assq 'candidates
                             (mozc-protobuf-get (mozc-session-sendkey '(space))
                                                'all-candidate-words)))))
    (when kkh-mozc-with-suggest
      (mozc-clean-up-session)
      (mozc-session-sendkey (list string))
      (setq suggested
            (mapcar (lambda (c) (cdr (assoc 'value c)))
                    (cdr (assq 'candidates
                               (mozc-protobuf-get (mozc-session-sendkey '(tab))
                                                  'all-candidate-words))))))
    (mozc-clean-up-session)
    (append (if (eq len (length key)) suggested nil)
            (if (member string converted) converted nil))))

(defun kkh-mozc-lookup-key-ad (orig-fun &rest args)
  (if kkh-mozc-enabled
      (apply #'kkh-mozc-lookup-key args)
    (apply orig-fun args)))

(defun kkh-mozc-toggle-enabled ()
  "`kkh-mozc-enabled' をトグルする."
  (interactive)
  (setq kkh-mozc-enabled (not kkh-mozc-enabled))
  (message "%s" (if kkh-mozc-enabled "Using Mozc" "Using Google API"))
  (kkh-lookup-key kkh-length-head)
  (kkh-update-conversion 'all))

(defun kkh-mozc-toggle-suggest ()
  "`kkh-mozc-with-suggest' をトグルする."
  (interactive)
  (when kkh-mozc-enabled
    (setq kkh-mozc-with-suggest (not kkh-mozc-with-suggest))
    (message "%s"
             (if kkh-mozc-with-suggest "With suggest" "Without suggest"))
    (kkh-lookup-key kkh-length-head)
    (kkh-update-conversion 'all)))

(defun kkh-mozc-toggle-suggest-ad (orig-fun &rest args)
  (if kkh-mozc-enabled
      (apply #'kkh-mozc-toggle-suggest args)
    (apply orig-fun args)))

(advice-add 'kkh-lookup-key-sub :around #'kkh-mozc-lookup-key-ad)
;; (advice-remove 'kkh-lookup-key-sub #'kkh-mozc-lookup-key-ad)

(advice-add 'kkh-toggle-use-ja-dic :around #'kkh-mozc-toggle-suggest-ad)
;; (advice-remove 'kkh-toggle-use-ja-dic #'kkh-mozc-toggle-suggest-ad)

(define-key kkh-keymap (kbd "C-z") 'kkh-mozc-toggle-enabled)
;; (define-key kkh-keymap (kbd "C-x") 'kkh-mozc-toggle-suggest)

(provide 'kkh-mozc)
;;; kkh-mozc.el ends here
