# Cthulhu-TRPG-Assistant

クトゥルフ神話TRPGのゲームシステム進行ツール  
概要などの詳細は↓にあります。

## OverView

### 要件
```
Nim   1.4.8
yaml  0.16.0
```
https://nim-lang.org/  
https://nimyaml.org/

### ゲームまでの手順
1. `start -f sample/locker.yml`

### 脚本を記述するYAMLの例
参考：[ロッカー](https://www.pixiv.net/novel/show.php?id=5774471)
```
- Title: ロッカー

- Player:
  - 野見山　祐介（のみやま　ゆうすけ）
    - summary: |
      巻き込まれてしまっただけの一般人。
      基本的性格は温和・真面目・面倒見がいい。
    ― text: |
      温和でやさしいしゃべり方をする青年。大学では数学を専攻しており、子供が好きなので小学校の先生を選んだ。
    - param:
      - STR: 12
      - DEX: 10
      - INT: 14
      - CON: 6
      - APP: 15
      - POW: 11
      - SIZ: 16
      - SAN: 55
      - EDU: 14
      - HP: 11
      - MP: 11
      - ﾀﾞﾒｰｼﾞﾎﾞｰﾅｽ: +1D4
      - 言いくるめ: 75％
      - 回避: 50％
      - 機械修理: 70％
      - 信用: 88％
      - 心理学: 22％
      - 説得: 85％
      - 図書館: 75％
      - 目星: 85％
    - item:
      - リュックサック
        - summary: |
          以下のアイテムが入っている
      - 算数の教材（九九）
        - summary: |
          九九の書かれたマグネット。
          「1×1」～「9×9」まである。
      - チョーク
      - 家の鍵
      - 財布
      - 携帯

- Event:
  - Start:
    - summary: |
      導入。部屋の不思議さと探索を行う状況を理解させる
    - text: |
      いつもと変わらない日常を過ごしていたあなたは一瞬めまいに襲われる。
      手で顔を覆い目を開けると、一面真っ白な壁に覆われた部屋にいた。
      部屋にあるのはずらりと壁に並ぶロッカーと一人の青年、探索者のみ。
    - item:
      - Player:
        - 野見山　祐介（のみやま　ゆうすけ）
    - meta:
      - asset:
        - back: （白い部屋の画像）
      - next:
        - NomiyamaPersonal
        - Locker

  - NomiyamaPersonal:
    - summary: |
      野見山の紹介。巻き込まれた一般人という印象をつける
      隠しパラメータとして好感度が設定されている。
      初期状態は5
      下がる行為：
        心理学: 2回行ごとに-1, 二人以上の同時心理学で-2
        SAN盾(ロッカーを代わりに覗かせるなど): -1
        暴力など: -1
    - text: |
      野見山に話しかけると、彼は困惑した様子で話し始めた。
      小学校の先生で、大学では数学を専攻していた。
      子供が好きなので小学校の先生を選んだそうだ。
      現在は2年生の担任を任されている。今日は九九を教えるために徹夜で教材を作ってきた。
      通勤中のバスで少しうたたねをしていたらここにいた。今の状況は本当に困惑している。
      温和でやさしいしゃべり方をする青年だ。

  - Locker:
    - summary: |
      ロッカーの全体。情報はあまり与えない。
    - text: |
      部屋の中央には、大人一人入れそうな、縦２ｍ、横幅１ｍほどのロッカーが５つ並んでいた。
      真ん中のロッカーは一回りサイズが大きく、「ロッカーのかぎ」と書かれている。
    - meta:
      - next:
        - Locker目星
        - Locker1
        - Locker2
        - Locker3
        - Locker4
        - Locker5

  - Locker目星:
    - text: |
      灰色の金属製のロッカーのようだ。
      真ん中以外の4つには、それぞれ100、23、67、36という数字が書かれている。
    - meta:
      - next:
        - Locker
```

## Detail

### 概要
クトゥルフ神話TRPGの進行には、ゲームの深い把握とプレイヤーの多様な行動に対する対応力が必要になります。  
`Cthulhu-TRPG-Assistant`はゲームキーパーの物語の把握、展開をアシストするスマートなメモとして働きます。

### 定義
ここではTRPGを「プレイヤーの選択肢（行動）と結末が無数に存在しうるノベルゲーム」と捉えます。（これに当てはまらない進行を行うTRPGはスコープ外です。）  
ゲームキーパーの役割は、事前に複数のストーリーを準備しておき、その順序や展開をプレイヤーの行動に合わせてチューニングし物語を作り上げることです。

### 構造
ストーリーを記述するために以下の要素を考えます。

#### Event
ストーリーの主体。
ストーリーの概要、プレイヤーに与える情報、次の展開、登場人物やアイテムなどの構成要素などを記述します。  
Eventは他のEventとの連関を持ち、ストーリーはEventの遷移によって進行していきます。

#### Player
キャラクター。  
バックボーンやパラメータを記述します。  
プレイヤーの操るキャラクターやNPC、神話生物もこの形式で記述可能です。

#### Item
武器、魔導書、アーティファクトなど。  
バックボーンや戦闘におけるパラメータなどを記述します。


### YAMLの構造
上記をYAMLに落とし込みます
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
    - skill:
      - 目星:
        - normal: |
          壁の一面に、ロッカーが5個横に並んでいる。
          100㎡ほどの明るい部屋で床や壁は真っ白だ。
          壁は見渡す限り白く、窓や通気口はおろか出入り口のようなものも見えない。
          部屋の中央には20代後半くらいの青年が呆然と立ち尽くしている。
          部屋の中央にうっすらと、
          『ここにはロッカーがある。ここにはロッカーしかない。さぁ出口はどこでしょう』と書いてある。
        - hard: |
          壁には何か不思議な力がかけられているようだ。
        - critical: |
          とても禍々しい気を感じられる。
          あなたは物理的な方法で壊すのは難しそうだ、と悟る。
        - fumble:
          白い部屋だ。
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
        # 変数の操作
        # Event終了時(別Eventへの遷移時)に自動で行われるので、プレイヤーの行動次第で回避できるものなどはsummaryに書き留める方を推奨
        - day1.time -= 3
        - poison.limit += 3
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
    # 所持品。
    - 小型ナイフ

― Item:
  # アイテムを記述します
  - summary:
  - Tomes: # 魔導書は専用の項目内で記述
    -
```
