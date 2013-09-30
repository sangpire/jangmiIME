assert = require 'assert'
ime = require "../"

describe 'jangmiIME', ->
  beforeEach (done) ->
    ime.jamoIn(" ")
    done()

  it "should return 'ㄱ' when type 'ㄱ'", ->
    assert.equal ime.jamoIn('ㄱ'), 'ㄱ'

  it "should return 'ㅏ' when type 'ㅏ'", ->
    assert.equal ime.jamoIn( 'ㅏ'), 'ㅏ'

  it "should return '가' when type 'ㄱㅏ'", ->
    ime.jamoIn 'ㄱ'
    ime.jamoIn 'ㅏ'
    assert.equal ime.getCurrentHangul(), '가'

