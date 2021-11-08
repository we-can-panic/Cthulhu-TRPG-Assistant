type
  TRPG* =object
    events*: seq[Event]
    players*: seq[Player]

  Event* = object
    name*: string
    summary*: string
    text*: string
    meta*: EventMeta

  Item* = object
    name*: string
    summary*: string
    meta*: ItemMeta

  Player* = object
    name*: string
    summary*: string
    text*: string
    param*: Param
    item*: seq[Item]


  Param* = object
    STR*: int
    DEX*: int
    INT*: int
    CON*: int
    APP*: int
    POW*: int
    SIZ*: int
    SAN*: int
    EDU*: int
    HP*: int
    MP*: int
    ﾀﾞﾒｰｼﾞﾎﾞｰﾅｽ*: string
    skill*: seq[Skill]

  Skill* = object
    name*: string
    summary*: string
    late*: float

  SkillResult* = object
    name*: string
    normal*: string
    hard*: string
    critical*: string
    fumble*: string


  ItemMeta* = object
    ﾀﾞﾒｰｼﾞﾎﾞｰﾅｽ*: string

  EventMeta* = object
    next*: seq[string]
    skill*: seq[SkillResult]
    item*: seq[Item]
    asset*: AssetMeta

  AssetMeta* = object
    front*: string
    back*: string
