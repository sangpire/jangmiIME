assert = require 'assert'
ime = require "../"

assertJamoIn = (inJamo, peep)->
  assert.equal ime.jamoIn(inJamo), peep

describe 'jangmiIME', ->
  beforeEach (done)->
    ime.reset()
    done()

  it "should return ㄱㄴㄷㄹㅁㅂ when type 'ㄱㄴㄷㄹㅁㅂ'", ->
    assertJamoIn 'ㄱ', 'ㄱ'
    assertJamoIn 'ㄴ', 'ㄱㄴ'
    assertJamoIn 'ㄷ', 'ㄴㄷ'
    assertJamoIn 'ㄹ', 'ㄷㄹ'
    assertJamoIn 'ㅁ', 'ㄹㅁ'

  it "should return 사랑 when type 'ㅅㅏㄹㅏㅇ'", ->
    assertJamoIn 'ㅅ', 'ㅅ'
    assertJamoIn 'ㅏ', '사'
    assertJamoIn 'ㄹ', '살'
    assertJamoIn 'ㅏ', '사라'
    assertJamoIn 'ㅇ', '랑'

  it "should return 장미 when type 'ㅈㅏㅇㅁㅣ'", ->
    assertJamoIn 'ㅈ', 'ㅈ'
    assertJamoIn 'ㅏ', '자'
    assertJamoIn 'ㅇ', '장'
    assertJamoIn 'ㅁ', '장ㅁ'
    assertJamoIn 'ㅣ', '미'

  it "should return '각' when type 'ㄱㅏㄱ'", ->
    assertJamoIn 'ㄱ', 'ㄱ'
    assertJamoIn 'ㅏ', '가'
    assertJamoIn 'ㄱ', '각'

  it "should return '냐' when type 'ㄴㅑ'", ->
    assertJamoIn 'ㄴ', 'ㄴ'
    assertJamoIn 'ㅑ', '냐'

  it "should return '가' when type 'ㄱㅏ'", ->
    assertJamoIn 'ㄱ', 'ㄱ'
    assertJamoIn 'ㅏ', '가'

  it "should return 'ㅏ' when type 'ㅏ'", ->
    assertJamoIn 'ㅏ', 'ㅏ'

  it "should return 'ㄱ' when type 'ㄱ'", ->
    assertJamoIn 'ㄱ', 'ㄱ'




