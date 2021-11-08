# yaml読み込み

import os, sequtils, strutils
import streams
import json, yaml

import object_define as o


proc dataLoad(dir: string): TRPG =
  for jsfile in walkDir(dir):
    var jsondata = jsfile.path.parseFile()
    if jsfile.path.endsWith("Event.json"):
      result.events = jsondata["Event"].to(seq[o.Event])
    elif jsfile.path.endsWith("Player.json"):
      result.players = jsondata["Player"].to(seq[o.Player])


proc dumpToJson*(data: YamlDocument, filename: string) =
  var s = newFileStream(filename, fmWrite)
  data.dumpDom(s, options= defineOptions(style = psJson) )
  s.close()

proc loadPlayer*(data: JsonNode): Player =
  for key, value in data:
    if value.kind==JObject:
      echo "p"

proc getDeepObjList*(data: JsonNode): seq[JsonNode] =
  # 1階層下のJsonObjectを抽出
  for k, v in data:
    if v.kind==JObject:
      result.add(v)

proc getDeepObjList*(data: seq[JsonNode]): seq[JsonNode] =
  for jn in data:
    result = result.concat(jn.getDeepObjList)

proc getAllObjectList*(data: JsonNode): seq[JsonNode] =
  var data2 = data.getDeepObjList
  while data2.len!=0:
    result = result.concat(data2)
    data2 = data2.getDeepObjList


when isMainModule:
  echo dataLoad("../sample/Locker")
