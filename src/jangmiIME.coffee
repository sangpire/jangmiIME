###

 JangmiIME
 https://github.com/sangpire/jangmiIME

 Copyright 2013 BYUN Sangpil(sangpire@gmail.com)
 JangmiIME under the Apache license, Version 2.0

Reference: 
  - Hangul Jamo : http://www.unicode.org/charts/PDF/U1100.pdf
  - Hangul Compatibility Jamo: http://www.unicode.org/charts/PDF/U3130.pdf
  - Hangul Syllables: http://www.unicode.org/charts/PDF/UAC00.pdf
###

info = debug = console.log
info = ->
debug = ->

UTF8_HANGUL_SYLLABLES_START     = 0xAC00
UTF8_HANGUL_COMPATIBILITY_START = 0x3131 #'ㄱ'.charCodeAt(0)
UTF8_JUNGSEONG_START            = 0x1161 #'ㅏ'.charCodeAt(0)
UTF8_CHOSEONG_DIFF              = '까'.charCodeAt(0) - '가'.charCodeAt(0)
UTF8_JUNGSEONG_DIFF             = '개'.charCodeAt(0) - '가'.charCodeAt(0)

isCompatibleJamoKeyCode = (keyCode) ->
  0x3131 <= keyCode <= 0x318e #Hangul Compatibility Jamo

compatibilityMultiJamoMap =
  'ㄱㄱ' : 0x1
  'ㄷㄷ' : 0x7
  'ㅂㅂ' : 0x12
  'ㅅㅅ' : 0x15
  'ㅈㅈ' : 0x18
  'ㅗㅏ' : 0x27
  'ㅗㅐ' : 0x28
  'ㅗㅣ' : 0x29
  'ㅜㅓ' : 0x2C
  'ㅜㅔ' : 0x2E
  'ㅜㅣ' : 0x2E
  'ㅡㅣ' : 0x31

choSeongMap =
  'ㄱ'   : 0 #'ᄀ'
  'ㄱㄱ' : 1 #'ᄁ'
  'ㄲ'   : 1 #'ᄁ'
  'ㄴ'   : 2 #'ᄂ'
  'ㄷ'   : 3 #'ᄃ'
  'ㄷㄷ' : 4 #'ᄄ'
  'ㄸ'   : 4 #'ᄄ'
  'ㄹ'   : 5 #'ᄅ'
  'ㅁ'   : 6 #'ᄆ'
  'ㅂ'   : 7 #'ᄇ'
  'ㅂㅂ' : 8 #'ᄈ'
  'ㅃ'   : 8 #'ᄈ'
  'ㅅ'   : 9 #'ᄉ'
  'ㅅㅅ' : 10 #'ᄊ'
  'ㅆ'   : 10 #'ᄊ'
  'ㅇ'   : 11 #'ᄋ'
  'ㅈ'   : 12 #'ᄌ'
  'ㅈㅈ' : 13 #'ᄍ'
  'ㅉ'   : 13 #'ᄍ'
  'ㅊ'   : 14 #'ᄎ'
  'ㅋ'   : 15 #'ᄏ'
  'ㅌ'   : 16 #'ᄐ'
  'ㅍ'   : 17 #'ᄑ'
  'ㅎ'   : 18 #'ᄒ'

jungSeongMap =
  'ㅏ'   : 0  #'ᅡ'
  'ㅐ'   : 1  #'ᅢ'
  'ㅑ'   : 2  #'ᅣ'
  'ㅒ'   : 3  #'ᅤ'
  'ㅓ'   : 4  #'ᅥ'
  'ㅔ'   : 5  #'ᅦ'
  'ㅕ'   : 6  #'ᅧ'
  'ㅖ'   : 7  #'ᅨ'
  'ㅗ'   : 8  #'ᅩ'
  'ㅘ'   : 9  #'ᅪ'
  'ㅗㅏ' : 9  #'ᅪ'
  'ㅙ'   : 10 #'ᅫ'
  'ㅗㅐ' : 10 #'ᅫ'
  'ㅚ'   : 11 #'ᅬ'
  'ㅗㅣ' : 11 #'ᅬ'
  'ㅛ'   : 12 #'ᅭ'
  'ㅜ'   : 13 #'ᅮ'
  'ㅝ'   : 14 #'ᅯ'
  'ㅜㅓ' : 14 #'ᅯ'
  'ㅞ'   : 15 #'ᅰ'
  'ㅜㅔ' : 15 #'ᅰ'
  'ㅟ'   : 16 #'ᅱ'
  'ㅜㅣ' : 16 #'ᅱ'
  'ㅠ'   : 17 #'ᅲ'
  'ㅡ'   : 18 #'ᅳ'
  'ㅢ'   : 19 #'ᅴ'
  'ㅡㅣ' : 19 #'ᅴ'
  'ㅣ'   : 20 #'ᅵ'

jongSeongMap =
  'ㄱ'   : 1  #'ᆨ'
  'ㄲ'   : 2  #'ᆩ'
  'ㄱㅅ' : 3  #'ᆪ'
  'ㄴ'   : 4  #'ᆫ'
  'ㄴㅈ' : 5  #'ᆬ'
  'ㄴㅎ' : 6  #'ᆭ'
  'ㄷ'   : 7  #'ᆮ'
  'ㄹ'   : 8  #'ᆯ'
  'ㄹㄱ' : 9  #'ᆰ'
  'ㄹㅁ' : 10  #'ᆱ'
  'ㄹㅂ' : 11 #'ᆲ'
  'ㄹㅅ' : 12 #'ᆳ'
  'ㄹㅌ' : 13 #'ᆴ'
  'ㄹㅍ' : 14 #'ᆵ'
  'ㄹㅎ' : 15 #'ᆶ'
  'ㅁ'   : 16 #'ᆷ'
  'ㅂ'   : 17 #'ᆸ'
  'ㅂㅅ' : 18 #'ᆹ'
  'ㅅ'   : 19 #'ᆺ'
  'ㅆ'   : 20 #'ᆻ'
  'ㅇ'   : 21 #'ᆼ'
  'ㅈ'   : 22 #'ᆽ'
  'ㅊ'   : 23 #'ᆾ'
  'ㅋ'   : 24 #'ᆿ'
  'ㅌ'   : 25 #'ᇀ'
  'ㅍ'   : 26 #'ᇁ'
  'ㅎ'   : 27 #'ᇂ'

class JangmiIME
  ###
  @handler =
    passed: (keyCode) ->
    added: (gul) ->
    changed: (gul) ->
  ###
  constructor: (@handler)->
    @reset()


  ###
  Reset Current State.
  ###
  reset: ->
    @curJamo = null
    [@choSeong, @jungSeong, @jongSeong] = [[], [], []]


  added: ->
    curGul = @peep()
    @handler.added curGul if curGul?

  changed: ->
    curGul = @peep()
    @handler.changed curGul if curGul?

  isEmpty: ->
    @choSeong.length + @jungSeong.length + @jongSeong.length is 0

  ###
  Add KeyCode
  ###
  add: (keyCode) ->
    if not isCompatibleJamoKeyCode keyCode
      debug "This keyCode is not Jamo=>#{keyCode}"
      @reset()
      @handler.passed keyCode
    else
      jamo = String.fromCharCode keyCode

      debug """\n
      added:'#{jamo}'
      wait :[#{@choSeong}|#{@jungSeong}|#{@jongSeong}]
      """

      if not @curJamo?
        @curJamo = @choSeong  if choSeongMap.hasOwnProperty jamo
        @curJamo = @jungSeong if jungSeongMap.hasOwnProperty jamo
        @curJamo.push jamo
        @added()
      else
        curJamo = @curJamo.join("") + jamo
        switch @curJamo
          when @choSeong
            debug ">CHOSEONG"
            if choSeongMap.hasOwnProperty curJamo
              @curJamo.push jamo
              @changed()
            else
              if choSeongMap.hasOwnProperty jamo
                @reset()
                @add keyCode
              else if jungSeongMap.hasOwnProperty jamo
                @jungSeong.push jamo
                @curJamo = @jungSeong
                @changed()
              else
                debug "CASE2"
          when @jungSeong
            debug ">JUNGSEONG"
            if jungSeongMap.hasOwnProperty curJamo
              @curJamo.push jamo
              @changed()
            else
              if jongSeongMap.hasOwnProperty jamo
                @jongSeong.push jamo
                @curJamo = @jongSeong
                @changed()
              else
                debug "CASE1"
          when @jongSeong
            debug ">JONGSEONG"
            if jongSeongMap.hasOwnProperty curJamo
              @curJamo.push jamo
              @changed()
            else
              if jungSeongMap.hasOwnProperty jamo
                temp = @curJamo.pop()
                @changed()
                @reset()
                @choSeong.push temp
                @jungSeong.push jamo
                @curJamo = @jungSeong
                @added()
              else
                @reset()
                @curJamo = null
                @add keyCode

  ###
  Delete Last Input
  ###
  back: ->
    if @curJamo.length > 0
      @curJamo.pop()
      @changed()
    else
      switch @curJamo
        when @jungSeong
          @curJamo = @choSeong
          @back()
        when @jongSeong
          @curJamo = @jungSeong
          @back()

  ###
    peep current hangul
  ###
  peep: ->
    debug """
    @peep {
      [#{@choSeong}|#{@jungSeong}|#{@jongSeong}]
    """

    if @choSeong.length > 0 and @jungSeong.length > 0
      code =  UTF8_HANGUL_SYLLABLES_START + choSeongMap[@choSeong.join("")] * UTF8_CHOSEONG_DIFF
      code += jungSeongMap[@jungSeong.join("")] * UTF8_JUNGSEONG_DIFF
      code += jongSeongMap[@jongSeong.join("")] if @jongSeong.length > 0
    else
      if @choSeong.length == 1
        code = @choSeong[0].charCodeAt 0
      else if @choSeong.length > 1
        code = UTF8_HANGUL_COMPATIBILITY_START + compatibilityMultiJamoMap[@choSeong.join("")]
      else if @jungSeong.length == 1
        code = @jungSeong[0].charCodeAt 0
      else if @jungSeong.length > 1
        code = UTF8_HANGUL_COMPATIBILITY_START + compatibilityMultiJamoMap[@jungSeong.join("")]
      else
        return ""
    
    debug """
    } => #{String.fromCharCode(code)}
    """

    String.fromCharCode code

module.exports = JangmiIME
