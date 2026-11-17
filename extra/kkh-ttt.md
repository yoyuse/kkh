# kkh-ttt.el

## 概要

kkh-ttt.el は kkh.el 上で **親指漢直** を利用する実験的機能です。

ひらがなは USかな入力で、漢字は `SPC` (スペースキー) シフトにより TT-code で入力します。

カタカナは、ひらがなで入力してカタカナ確定するか、 TT-code で入力します。

## 設定

### kkh.el と ttt.el の設定

[kkh.el](https://github.com/yoyuse/kkh) 本体に加えて、漢直 (TT-code) を利用するために [ttt.el](https://github.com/yoyuse/ttt) が必要です。
あらかじめインストールしておきます。

### `SPC` シフトの設定

[Karabiner-Elements](https://karabiner-elements.pqrs.org/) などを利用して、以下のいずれかの設定をします。

- (Emacs 使用時) `SPC` でシフトしたときに `|` (VERTICAL LINE) を前置する
- (Emacs 使用時) `SPC` を押したときに `F14` を、離したときに `F15` を送る

例えば、 `SPC` を押しながら `l` `4` `z` `/` とタイプすると、 `|` `l` `|` `4` `|` `z` `|` `/` または、 `f14` `l` `4` `z` `/` `f15` というキー列が Emacs に送られるようにします。

### kkh-ttt.el の設定

kkh-ttt.el を `load-path` の通ったところに置いて init.el に次の式を追記します。

``` emacs-lisp
(when (and (require 'kkh nil t)
           (require 'ttt nil t))
  (require 'kkh-ttt)
  ;; 親指漢直の有効化
  (setq kkh-ttt-enabled t)
  ;; 無変換/変換 で ひらがな確定/カタカナ確定
  (let ((map (quail-conversion-keymap)))
    (define-key map (kbd "<muhenkan>") 'kkh-translit-commit-hiragana)
    (define-key map (kbd "<henkan>") 'kkh-translit-commit-katakana))
  (let ((map kkh-keymap))
    (define-key map (kbd "<muhenkan>") 'kkh-conv-hiragana)
    (define-key map (kbd "<henkan>") 'kkh-conv-katakana)))
```

### 入力方法

kkh.el の日本語入力モードを ON にした状態で、

- ひらがなは、そのまま USかな配列で、
- 漢字は、 `SPC` を押しながら TT-code で、

それぞれタイプし、ひらがな確定キー `C-u` (`kkh-translit-commit-hiragana`) を打つと、かな漢字混じり文として入力されます。

カタカナは、

- USかな配列で入力して、カタカナ確定キー `C-k` (`kkh-translit-commit-katakana`) を、
- あるいは、ひらがなや漢字と同様に TT-code で入力して `C-u` を、

それぞれ打つと、入力されます。
前者は、かなとしての打鍵数は減らせますが、そのつど確定が必要で、
後者は、確定は一括で行えますが、打鍵数は USかなより増加します。
筆者は TT-code で入力してしまうことが多いです。

英数字や記号は、英字確定キー `C-l` (`quail-no-conversion`) で明示的に確定するか、 `SPC`/`RET`/`TAB` などによる暗黙的な無変換確定で入力します。

### TIPS

- ttt.el の **補換** (補助変換) は、例えば `SPC`-`fjfjjendz/` とタイプすると Emacs のエコーエリアには `◇かん字` のようにプレビューされますが、そのまま `C-u` を打つと実際の変換が行われて `換字` や `漢字` などを入力することができます

### 既知の問題

- `SPC` を漢直のシフトに使用するため、通常の空白の入力に影響が出ます
  - キーリピートによる空白の入力ができない、
  - `SPC` のあとのロールオーバーが漢直シフトになってしまう、など
- ~~TT-code で入力できる半角英数記号文字は、`! ? % ( ) 1 2 3 4 5 6 7 8 9 0` の 15 字ありますが、このうち `!` を除く 14 字は、 USかな打鍵と解釈されて `・ ぇ ょ を ぬ ふ あ う え お や ゆ よ わ` に化けてしまいます~~
  → 対処しました (`kkh-ttt-zenkaku-hankaku`)

### `SPC` シフトの設定例 (Karabiner-Elements)

以下は、

> - (Emacs 使用時) `SPC` を押したときに `F14` を、離したときに `F15` を送る

という設定の JSON の例です。

``` json
{
    "description": "親指漢直 (f14/f15) [Emacs]",
    "manipulators": [
        {
            "conditions": [
                {
                    "bundle_identifiers": [
                        "^org\\.gnu\\.Emacs$"
                    ],
                    "type": "frontmost_application_if"
                },
                {
                    "name": "spc-tap",
                    "type": "variable_if",
                    "value": 1
                }
            ],
            "from": {
                "key_code": "spacebar"
            },
            "to": [
                {
                    "set_variable": {
                        "name": "spc-tap",
                        "value": 0
                    }
                }
            ],
            "to_if_held_down": [
                {
                    "key_code": "spacebar"
                }
            ],
            "type": "basic"
        },
        {
            "conditions": [
                {
                    "bundle_identifiers": [
                        "^org\\.gnu\\.Emacs$"
                    ],
                    "type": "frontmost_application_if"
                }
            ],
            "from": {
                "key_code": "spacebar"
            },
            "to": [
                {
                    "key_code": "f14"
                },
                {
                    "set_variable": {
                        "name": "spc-tap",
                        "value": 1
                    }
                }
            ],
            "to_after_key_up": [
                {
                    "key_code": "f15"
                }
            ],
            "to_delayed_action": {
                "to_if_canceled": [
                    {
                        "set_variable": {
                            "name": "spc-tap",
                            "value": 0
                        }
                    }
                ],
                "to_if_invoked": [
                    {
                        "set_variable": {
                            "name": "spc-tap",
                            "value": 0
                        }
                    }
                ]
            },
            "to_if_alone": [
                {
                    "key_code": "spacebar"
                }
            ],
            "type": "basic"
        }
    ]
}
```

### 参考サイト

- [「親指漢直」とは何か？(1) - 錬金術師の実験室](https://web.archive.org/web/20211204133509/http://homeposition.net/~m%28as%29m/blog/2015/08/whats-oyayubi-kanchoku-1.html)
- [DvorakJとGoogle日本語入力の連携による各種キー配列への対応 - 錬金術師の実験室](https://web.archive.org/web/20211204141027/http://homeposition.net/~m%28as%29m/blog/2015/12/15-advent.html)
