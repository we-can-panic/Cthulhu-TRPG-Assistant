# 未完成

# Cthulhu-TRPG-Assistant

クトゥルフ神話TRPGのゲームシステム進行ツール

## ゲームまでの手順
1.
1. `start -f sample/witch_house.yml`

## 概要
クトゥルフ神話TRPGの進行には、ゲームの深い把握とプレイヤーの多様な行動に対する対応力が必要になります。
このツールはそれをアシストするスマートなメモのような存在です。

### 定義
（一部の）TRPGは、選択肢（行動）と結末が無数に存在しうるノベルゲーム、と捉えることができます。
ここでのゲームキーパーの役割は、事前にいくつかのストーリーを想定しておいて、その順序や展開をプレイヤーの行動に合わせて書き換え、プレイヤーに満足のいくストーリーを提供することです。`Cthulhu-TRPG-Assistant`はそれを助けることを目的としています。

なので、これに当てはまらない進行を行うTRPG（「ヒトラーが魔導書を持ったら第二次世界大戦はどのようになっていた？」など）は、このツールの対象外です。

（現実的には、全てのユーザの行動を事前に定義することはできないでしょう。
`Cthulhu-TRPG-Assistant`は、シナリオからはみ出してしまったアドリブ的なイベントとの親和性も考慮しています。）

### 構造
ストーリーを記述するために、以下の要素を考えます。

#### Event
ストーリーの主体。
ストーリーの概要、プレイヤーに与える情報、次の展開、登場人物やアイテムなどの構成要素などを記述します。
Eventは他のEventとの連関を持ち、ストーリーはEventの遷移によって進行していきます。

#### Player
キャラクター。
バックボーンやパラメータを記述します。
プレイヤーの操るキャラクターやNPC、神話生物もこの形式で記述可能です。

#### Item
アイテム。
バックボーンや戦闘におけるパラメータなどを記述します。


### YAMLの構造
```
- Title: hoge
- Event:
  - <イベント名>: # 最初のEventは「Start」です
    - summary:
      # Eventの目的や雰囲気など、キーパーが進行時に気を付けることを書きます
      This is start event.
    - text:
      # 導入を書きます。Eventに入った瞬間にプレイヤーが得られる情報です
      Hello, world!
    - item:
      # アイテムやNPCなど、舞台を構成する情報を書きます。「目星」などプレイヤーの行動に応じて情報を展開します。
      - Player: # キャラクターの定義（詳しくは後述）は、簡易的にEvent内でも定義可能です
        - NIGG
          - summary: NPC
      - 小型ナイフ # ルールブックの情報を名前から参照できます
      - 日記 # Playerと同じく、EventもEvent内で定義可能です
        - Event:
          - reading-book:
            - summary:
              ミ・ゴが関与していることをほのめかす
              場合によっては3+1D10のSANCが発生
            - text:
              日記には、・・・
            - meta: - var: time -= 1
    - meta:
      # ここにゲームの進行に影響を与える情報を書きます。
      - asset: # 背景の書き換えなど。Event開始時に反映。
        - back: AAA.png
      - next: # 他のEventとのリンク情報
        - Event1-battle # リンクを相互に繋げることで、イベントを細かい単位で切り分けられます。
        - Event2
        - Event3
      - var:
        # (隠れ)変数の操作
        # Event終了時(別Eventへの遷移時)に自動で行われるので、プレイヤーの行動次第で回避できるものなどはsummaryに書き留める方を推奨
        - day1.time -= 3
        - poison.interval += 3
        # 内部動作はNimで動かしています
        - if poison.interval > 10: poison.applyDamage()

- Player:
  # プレイヤーのキャラクター、もしくはNPCを記述します。
  - summary:
    # プレイヤーの設定を書きます。
  - param:
    # INTとかCONとかを書きます。
    # インポート可能(TODO: インポート機能の仕様決め)
    - INT: 50
  - item:
    # 所持品。ものによってはルールブックの情報を名前から参照できます
    - 小型ナイフ

― Item:
  # アイテムを記述します
  - summary:


```
#### 例
```
- Title: 魔女の家

- Player:
  - summary:
  - param:
    - INT:
    ...

- Event:
  - Start:
    - summary:
      -


```