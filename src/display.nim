import strutils, sequtils, math, random
import object_define as o

randomize()

proc getDetailFromName(obj: seq[Event], name: string): Event =
  for e in obj:
    if e.name==name:
      return e
  echo "none..."


proc getDetailFromName(obj: seq[Player], name: string): Player =
  for e in obj:
    if e.name==name:
      return e
  echo "none..."

proc getDetailFromName(obj: seq[SkillResult], name: string): SkillResult =
  for e in obj:
    if e.name==name:
      return e
  echo "none..."


proc start*(obj: TRPG) =
  var input: string
  var
    nowEv = obj.events.getDetailFromName("Start")
    nowPl: Player
  while true:
    stdout.write ">>> "
    input = stdin.readLine.strip
    case input.split[0]:
      of "help":
        # コマンドの確認
        echo "now", "\t", "現在のイベント、対峙人物"
        echo "summary", "\t", "現在のイベントの概要"
        echo "text", "\t", "現在のイベントの説明"
        echo "next", "\t", "次に遷移するイベント一覧"
        echo "skill", "\t", "使えるスキル一覧"
        echo "mv", "\t", "イベントの変更"
        echo "battle", "\t", "対峙人物の変更"
        echo "player", "\t", "プレイヤー一覧"
        echo "D", "\t", "ダイスロール"
      of "summary":
        echo nowEv.summary
      of "text":
        echo nowEv.text
      of "now":
        # 居場所の確認
        echo "Ev: ", nowEv.name
        echo "Pl: ", nowPl.name
      of "next":
        for i in nowEv.meta.next:
          echo i
      of "skill":
        if input.split.len==1:
          for i in nowEv.meta.skill:
            echo i.name
        else:
          var name = input.split[1]
          var skill = nowEv.meta.skill.getDetailFromName(name)
          echo "normal", "\t", skill.normal
          echo "hard", "\t", skill.hard
          echo "critical", "\t", skill.critical
          echo "fumble", "\t", skill.fumble
      of "mv":
        if input.split.len==2:
          var name = input.split[1]
          echo name
          nowEv = obj.events.getDetailFromName(name)
        else:
          echo "ex. :", "mv <nextEv>"
      of "battle":
        if input.split.len>1:
          var name = input.split[1]
          nowPl = obj.players.getDetailFromName(name)
          echo nowPl.name
          echo "summary", "\t", nowPl.summary
          echo "text", "\t", nowPl.text
          echo "param:"
          echo " STR", "\t", nowPl.param.STR
          echo " DEX", "\t", nowPl.param.DEX
          echo " INT", "\t", nowPl.param.INT
          echo " CON", "\t", nowPl.param.CON
          echo " APP", "\t", nowPl.param.APP
          echo " POW", "\t", nowPl.param.POW
          echo " HP", "\t", nowPl.param.HP
          echo " MP", "\t", nowPl.param.MP
          echo " SIZ", "\t", nowPl.param.SIZ
          echo " SAN", "\t", nowPl.param.SAN
          echo " EDU", "\t", nowPl.param.EDU
          echo "ﾀﾞﾒｰｼﾞﾎﾞｰﾅｽ", "\t", nowPl.param.ﾀﾞﾒｰｼﾞﾎﾞｰﾅｽ
          echo "skill:"
          for i in nowPl.param.skill:
            echo " ", i.name, "\t", i.summary, "\t", i.late
        else:
          echo "ex. : <player名>"
      of "player":
        for i in obj.players:
          echo i.name
      of "D":
        if input.split.len==3:
          var round = input.split[1].parseInt
          var scale = input.split[2].parseInt
          var dres: seq[int]
          for i in 1..round:
            dres.add((1..scale).rand)
          echo dres.mapIt($it).join(" + "), " = ", dres.sum()
        else:
          echo "ex. : ", "D 1 6"
