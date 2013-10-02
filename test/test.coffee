assert = require 'assert'
ime = require "../"

describe 'jangmiIME', ->
  beforeEach (done) ->
    ime.reset()
    done()

  it "should return 'ㄱ' when type 'ㄱ'", ->
    assert.equal ime.jamoIn('ㄱ'), 'ㄱ'

  it "should return 'ㅏ' when type 'ㅏ'", ->
    assert.equal ime.jamoIn( 'ㅏ'), 'ㅏ'

  it "should return '가' when type 'ㄱㅏ'", ->
    ime.jamoIn 'ㄱ'
    assert.equal ime.jamoIn('ㅏ'), '가'

  it "should return '냐' when type 'ㄴㅑ'", ->
    ime.jamoIn 'ㄴ'
    assert.equal ime.jamoIn('ㅑ'), '냐'

  it "should return '각' when type 'ㄱㅏㄱ'", ->
    ime.jamoIn 'ㄱ'
    ime.jamoIn 'ㅏ'
    assert.equal ime.jamoIn('ㄱ'), '가'

