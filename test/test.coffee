assert = require 'assert'
ime = require "../"

assertJamoIn = (inJamo, peep)->
  assert.equal ime.jamoIn(inJamo), peep

describe 'jangmiIME', ->
  beforeEach (done)->
    ime.reset()
    done()

  it "should return 밥&미 when type 'ㅂㅏㅂ&ㅁㅣ'", ->
    assertJamoIn 'ㅂ' , 'ㅂ'
    assertJamoIn 'ㅏ' , '바'
    assertJamoIn 'ㅂ' , '밥'
    assertJamoIn '&'  , '밥&'
    assertJamoIn 'ㅁ' , 'ㅁ'
    assertJamoIn 'ㅣ' , '미'

  it "should return 미&밥 when type 'ㅁㅣ&ㅂㅏㅂ'", ->
    assertJamoIn 'ㅁ' , 'ㅁ'
    assertJamoIn 'ㅣ' , '미'
    assertJamoIn '&'  , '미&'
    assertJamoIn 'ㅂ' , 'ㅂ'
    assertJamoIn 'ㅏ' , '바'
    assertJamoIn 'ㅂ' , '밥'

  it "should return 뷁 when type 'ㅂㅜㅔㄹㄱ'", ->
    assertJamoIn 'ㅂ' , 'ㅂ'
    assertJamoIn 'ㅜ' , '부'
    assertJamoIn 'ㅔ' , '붸'
    assertJamoIn 'ㄹ' , '뷀'
    assertJamoIn 'ㄱ' , '뷁'

  it "should return 한 글 when type 'ㅎㅏㄴ[SPACE]ㄱㅡㄹ'", ->
    assertJamoIn 'ㅎ' , 'ㅎ'
    assertJamoIn 'ㅏ' , '하'
    assertJamoIn 'ㄴ' , '한'
    assertJamoIn ' '  , '한 '
    assertJamoIn 'ㄱ' , 'ㄱ'
    assertJamoIn 'ㅡ' , '그'
    assertJamoIn 'ㄹ' , '글'

  it "should return ㄱㄴㄷㄹㅁㅂ when type 'ㄱㄴㄷㄹㅁㅂ'", ->
    assertJamoIn 'ㄱ' , 'ㄱ'
    assertJamoIn 'ㄴ' , 'ㄱㄴ'
    assertJamoIn 'ㄷ' , 'ㄴㄷ'
    assertJamoIn 'ㄹ' , 'ㄷㄹ'
    assertJamoIn 'ㅁ' , 'ㄹㅁ'

  it "should return 사랑 when type 'ㅅㅏㄹㅏㅇ'", ->
    assertJamoIn 'ㅅ' , 'ㅅ'
    assertJamoIn 'ㅏ' , '사'
    assertJamoIn 'ㄹ' , '살'
    assertJamoIn 'ㅏ' , '사라'
    assertJamoIn 'ㅇ' , '랑'

  it "should return 장미 when type 'ㅈㅏㅇㅁㅣ'", ->
    assertJamoIn 'ㅈ' , 'ㅈ'
    assertJamoIn 'ㅏ' , '자'
    assertJamoIn 'ㅇ' , '장'
    assertJamoIn 'ㅁ' , '장ㅁ'
    assertJamoIn 'ㅣ' , '미'

  it "should return '각' when type 'ㄱㅏㄱ'", ->
    assertJamoIn 'ㄱ' , 'ㄱ'
    assertJamoIn 'ㅏ' , '가'
    assertJamoIn 'ㄱ' , '각'

  it "should return '냐' when type 'ㄴㅑ'", ->
    assertJamoIn 'ㄴ' , 'ㄴ'
    assertJamoIn 'ㅑ' , '냐'

  it "should return '가' when type 'ㄱㅏ'", ->
    assertJamoIn 'ㄱ' , 'ㄱ'
    assertJamoIn 'ㅏ' , '가'

  it "should return 'ㅏ' when type 'ㅏ'" , ->
    assertJamoIn 'ㅏ' , 'ㅏ'

  it "should return 'ㄱ' when type 'ㄱ'", ->
    assertJamoIn 'ㄱ' , 'ㄱ'




