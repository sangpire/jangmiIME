assert = require 'assert'
JangmiIME = require "../"

passedKeyCode = addedGul = changedGul = null

ime = new JangmiIME
  passed: (keyCode) ->
    passedKeyCode = keyCode
  added: (gul) ->
    addedGul = gul
  changed: (gul) ->
    changedGul = gul


assertKeyCodeAdd = (inputKeyCode, expectedAddedGul, expectedChangedGul, expectedPassedKeyCode)->
  ime.add inputKeyCode
  assert.equal addedGul      , expectedAddedGul      if expectedAddedGul?
  assert.equal changedGul    , expectedChangedGul    if expectedChangedGul?
  assert.equal passedKeyCode , expectedPassedKeyCode if expectedPassedKeyCode?

assertJamoAdd = (jamo, expectedAddedGul, expectedChangedGul, expectedPassedKeyCode)->
  assertKeyCodeAdd jamo.charCodeAt(0), expectedAddedGul, expectedChangedGul, expectedPassedKeyCode

assertJamoBack = (expectedAddedGul, expectedChangedGul, expectedPassedKeyCode)->
  ime.back()
  assert.equal addedGul      , expectedAddedGul      if expectedAddedGul?
  assert.equal changedGul    , expectedChangedGul    if expectedChangedGul?
  assert.equal passedKeyCode , expectedPassedKeyCode if expectedPassedKeyCode?

describe "JangmiIME", ->
  beforeEach (done) ->
    passedKeyCode = addedGul = changedGul = null
    ime.reset()
    done()

  it "should ㄱ rightly write and delete.", ->
    assertJamoAdd 'ㄱ' , 'ㄱ'
    assertJamoBack null , ''

  it "should 깎 rightly write and delete by jamo.", ->
    assertJamoAdd 'ㄱ' , 'ㄱ'
    assertJamoAdd 'ㄱ' , null , 'ㄲ'
    assertJamoAdd 'ㅏ' , null , '까'
    assertJamoAdd 'ㄲ' , null , '깎'
    assertJamoBack null , '까'
    assertJamoBack null , 'ㄲ'
    assertJamoBack null , 'ㄱ'
    assertJamoBack null , ''

  it "should return 신장미 when type 'ㅅㅣㄴㅈㅏㅇㅁㅣ'", ->
    assertJamoAdd 'ㅅ' , 'ㅅ'
    assertJamoAdd 'ㅣ' , null , '시'
    assertJamoAdd 'ㄴ' , null , '신'
    assertJamoAdd 'ㅈ' , null , '싡'
    assertJamoAdd 'ㅏ' , '자' , '신'
    assertJamoAdd 'ㅇ' , null , '장'
    assertJamoAdd 'ㅁ' , 'ㅁ'
    assertJamoAdd 'ㅣ' , null , '미'

  it "should return ㅏㄱ when type 'ㅏㄱ'", ->
    assertJamoAdd 'ㅏ' , 'ㅏ'
    assertJamoAdd 'ㄱ' , 'ㄱ'

  it "should return 깨끗 when type 'ㄱㄱㅐㄲㅡㅅ'", ->
    assertJamoAdd 'ㄱ' , 'ㄱ'
    assertJamoAdd 'ㄱ' , null , 'ㄲ'
    assertJamoAdd 'ㅐ' , null , '깨'
    assertJamoAdd 'ㄲ' , null , '깪'
    assertJamoAdd 'ㅡ' , '끄'
    assertJamoAdd 'ㅅ' , null , '끗'

  it "should return 밥&미 when type 'ㅂㅏㅂ&ㅁㅣ'", ->
    assertJamoAdd 'ㅂ' , 'ㅂ'
    assertJamoAdd 'ㅏ' , null , '바'
    assertJamoAdd 'ㅂ' , null , '밥'
    assertJamoAdd '&'  , null , null , '&'.charCodeAt 0
    assertJamoAdd 'ㅁ' , 'ㅁ'
    assertJamoAdd 'ㅣ' , null , '미'

  it "should return 미&밥 when type 'ㅁㅣ&ㅂㅏㅂ'", ->
    assertJamoAdd 'ㅁ' , 'ㅁ'
    assertJamoAdd 'ㅣ' , null , '미'
    assertJamoAdd '&'  , null , null , '&'.charCodeAt 0
    assertJamoAdd 'ㅂ' , 'ㅂ'
    assertJamoAdd 'ㅏ' , null , '바'
    assertJamoAdd 'ㅂ' , null , '밥'

  it "should return 뷁 when type 'ㅂㅜㅔㄹㄱ'", ->
    assertJamoAdd 'ㅂ' , 'ㅂ'
    assertJamoAdd 'ㅜ' , null , '부'
    assertJamoAdd 'ㅔ' , null , '붸'
    assertJamoAdd 'ㄹ' , null , '뷀'
    assertJamoAdd 'ㄱ' , null , '뷁'

  it "should return 한 글 when type 'ㅎㅏㄴ[SPACE]ㄱㅡㄹ'", ->
    assertJamoAdd 'ㅎ' , 'ㅎ'
    assertJamoAdd 'ㅏ' , null , '하'
    assertJamoAdd 'ㄴ' , null , '한'
    assertJamoAdd ' '  , null , null , ' '.charCodeAt 0
    assertJamoAdd 'ㄱ' , 'ㄱ'
    assertJamoAdd 'ㅡ' , null , '그'
    assertJamoAdd 'ㄹ' , null , '글'

  it "should return ㄱㄴㄷㄹㅁㅂ when type 'ㄱㄴㄷㄹㅁㅂ'", ->
    assertJamoAdd 'ㄱ' , 'ㄱ'
    assertJamoAdd 'ㄴ' , 'ㄴ'
    assertJamoAdd 'ㄷ' , 'ㄷ'
    assertJamoAdd 'ㄹ' , 'ㄹ'
    assertJamoAdd 'ㅁ' , 'ㅁ'

  it "should return 사랑 when type 'ㅅㅏㄹㅏㅇ'", ->
    assertJamoAdd 'ㅅ' , 'ㅅ'
    assertJamoAdd 'ㅏ' , null , '사'
    assertJamoAdd 'ㄹ' , null , '살'
    assertJamoAdd 'ㅏ' , '라' , '사'
    assertJamoAdd 'ㅇ' , null , '랑'

  it "should return 장미 when type 'ㅈㅏㅇㅁㅣ'", ->
    assertJamoAdd 'ㅈ' , 'ㅈ'
    assertJamoAdd 'ㅏ' , null , '자'
    assertJamoAdd 'ㅇ' , null , '장'
    assertJamoAdd 'ㅁ' , 'ㅁ'
    assertJamoAdd 'ㅣ' , null , '미'

  it "should return '각' when type 'ㄱㅏㄱ'", ->
    assertJamoAdd 'ㄱ' , 'ㄱ'
    assertJamoAdd 'ㅏ' , null , '가'
    assertJamoAdd 'ㄱ' , null , '각'

  it "should return '냐' when type 'ㄴㅑ'", ->
    assertJamoAdd 'ㄴ' , 'ㄴ'
    assertJamoAdd 'ㅑ' , null , '냐'

  it "should return '가' when type 'ㄱㅏ'", ->
    assertJamoAdd 'ㄱ' , 'ㄱ'
    assertJamoAdd 'ㅏ' , null , '가'

  it "should return 'ㅢ' when type 'ㅡㅣ'" , ->
    assertJamoAdd 'ㅡ' , 'ㅡ'
    assertJamoAdd 'ㅣ' , null , 'ㅢ'

  it "should return 'ㅏ' when type 'ㅏ'" , ->
    assertJamoAdd 'ㅏ' , 'ㅏ'

  it "should return 'ㄲ' when type 'ㄱㄱ'", ->
    assertJamoAdd 'ㄱ' , 'ㄱ'
    assertJamoAdd 'ㄱ' , null , 'ㄲ'

  it "should return 'ㄱ' when type 'ㄱ'", ->
    assertJamoAdd 'ㄱ' , 'ㄱ'

  it "should return 어ㅠㅠ when type 'ㅇㅓㅠㅠ'", ->
    assertJamoAdd 'ㅇ' , 'ㅇ'
    assertJamoAdd 'ㅓ' , null , '어'
    assertJamoAdd 'ㅠ' , 'ㅠ'
    assertJamoAdd 'ㅠ' , 'ㅠ'
