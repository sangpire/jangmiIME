assert = require 'assert'
ime = require "../"

describe 'jangmiIME', ->
  beforeEach (done) ->
    ime.clear()
    done()
#
#  it "should return 'ㄱ' when type 'ㄱ'", ->
#    ime.jamoIn 'ㄱ'
#    assert.equal ime.getCurrentHangul(), 'ㄱ'
#
#  it "should return 'ㅏ' when type 'ㅏ'", ->
#    ime.jamoIn 'ㅏ'
#    assert.equal ime.getCurrentHangul(), 'ㅏ'
#
  it "should return '가' when type 'ㄱㅏ'", ->
    ime.jamoIn 'ㄱ'
    ime.jamoIn 'ㅏ'
    assert.equal ime.getCurrentHangul(), '가'

