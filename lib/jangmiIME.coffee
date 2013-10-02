###
Reference: 
  - Hangul Jamo : http://www.unicode.org/charts/PDF/U1100.pdf
  - Hangul Compatibility Jamo: http://www.unicode.org/charts/PDF/U3130.pdf
  - Hangul Syllables: http://www.unicode.org/charts/PDF/UAC00.pdf

Range
  choSeong = [0x1100..0x1112]
  jungSeong = [0x1161..0x1175]
  jongSeong = [0x11A8..0x11CE]
###

debug = console.log

UTF8_START_CODE     = 0xAC00
UTF8_CHOSEONG_DIFF  = '까'.charCodeAt(0) - '가'.charCodeAt(0)
UTF8_JUNGSEONG_DIFF = '개'.charCodeAt(0) - '가'.charCodeAt(0)
UTF8_JONGSEONG_DIFF = '각'.charCodeAt(0) - '가'.charCodeAt(0)

class Hangul
  ###
  @listener =
    write: call
  ###
  constructor: (@listener)->
    @curJamo = ""

  reset: ->
    @curJamo = ""
    [@choSeong, @jungSeong, @jongSeong] = [null, null, null]

  setChoSeong: (@choSeong) ->
  setJungSeong: (@jungSeong) ->
  setJongSeong: (@jongSeong) ->

  isWaitChoSeong: ->
    not @jungSeong?
  isWaitJungSeong: ->
    @choSeong? and not @jongSeong?
  isWaitJongSeong: ->
    @choSeong? and @jungSeong?

  add: (jamo) ->
    @curJamo += jamo
    debug ">#{jamo}< ==> #{@curJamo}"
    debug "isWaitSeong: #{@isWaitJungSeong()}"
    debug "isWaitJungSeong: #{@isWaitJungSeong()}"
    if @isWaitChoSeong()
      if choSeongMap.hasOwnProperty @curJamo
        @choSeong = @curJamo
      else
        if jungSeongMap.hasOwnProperty jamo
          if hangul.isWaitJungSeong()
            @curJamo = jamo
            @jungSeong = @curJamo
          else
            @listener.write jamo
    else if @isWaitJungSeong()
    else if isWaitJongSeong()
    else

  ###
    peep current hangul
  ###
  peep: ->
    debug "[#{@choSeong}|#{@jungSeong}|#{@jongSeong}]"
    if @choSeong? and @jungSeong?
      code = UTF8_START_CODE + choSeongMap[@choSeong]
      code += jungSeongMap[@jungSeong] * UTF8_JUNGSEONG_DIFF
      code += jongSeongMap[@jongSeong] * UTF8_JONGSEONG_DIFF if @jongSeong?
      String.fromCharCode code
    else
      @choSeong


written = null
hangul = new Hangul
  write: (gul) ->
    debug "hangul writed as #{gul}"
    written = gul

exports.reset = ->
  hangul.reset()

exports.jamoIn = (jamo) ->
  hangul.add jamo
  if written?
    [ret, written] = [written, null]
    ret
  else
    hangul.peep()


choSeongMap =
  'ㄱ':0 #'ᄀ'
  'ㄲ':1 #'ᄁ'
  'ㄴ':2 #'ᄂ'
  'ㄷ':3 #'ᄃ'
  'ㄸ':4 #'ᄄ'
  'ㄹ':5 #'ᄅ'
  'ㅁ':6 #'ᄆ'
  'ㅂ':7 #'ᄇ'
  'ㅃ':8 #'ᄈ'
  'ㅅ':9 #'ᄉ'
  'ㅆ':10#'ᄊ'
  'ㅇ':11#'ᄋ'
  'ㅈ':12#'ᄌ'
  'ㅉ':13#'ᄍ'
  'ㅊ':14#'ᄎ'
  'ㅋ':15#'ᄏ'
  'ㅌ':16#'ᄐ'
  'ㅍ':17#'ᄑ'
  'ㅎ':18#'ᄒ'

jungSeongMap =
  'ㅏ':0  #'ᅡ'
  'ㅐ':1  #'ᅢ'
  'ㅑ':2  #'ᅣ'
  'ㅒ':3  #'ᅤ'
  'ㅓ':4  #'ᅥ'
  'ㅔ':5  #'ᅦ'
  'ㅕ':6  #'ᅧ'
  'ㅖ':7  #'ᅨ'
  'ㅗ':8  #'ᅩ'
  'ㅘ':9  #'ᅪ'
  'ㅗㅏ':9  #'ᅪ'
  'ㅙ':10 #'ᅫ'
  'ㅗㅐ':10 #'ᅫ'
  'ㅚ':11 #'ᅬ'
  'ㅗㅣ':11 #'ᅬ'
  'ㅛ':12 #'ᅭ'
  'ㅜ':13 #'ᅮ'
  'ㅝ':14 #'ᅯ'
  'ㅜㅓ':14 #'ᅯ'
  'ㅞ':15 #'ᅰ'
  'ㅜㅔ':15 #'ᅰ'
  'ㅟ':16 #'ᅱ'
  'ㅜㅣ':16 #'ᅱ'
  'ㅠ':17 #'ᅲ'
  'ㅡ':18 #'ᅳ'
  'ㅢ':19 #'ᅴ'
  'ㅡㅣ':19 #'ᅴ'
  'ㅣ':20 #'ᅵ'

jongSeongMap =
  'ᆨ':0
  'ᆩ':1
  'ᆪ':2
  'ᆫ':3
  'ᆬ':4
  'ᆭ':5
  'ᆮ':6
  'ᆯ':7
  'ᆰ':8
  'ᆱ':9
  'ᆲ':10
  'ᆳ':11
  'ᆴ':12
  'ᆵ':13
  'ᆶ':14
  'ᆷ':15
  'ᆸ':16
  'ᆹ':17
  'ᆺ':18
  'ᆻ':19
  'ᆼ':20
  'ᆽ':21
  'ᆾ':22
  'ᆿ':23
  'ᇀ':24
  'ᇁ':25
  'ᇂ':26
  'ᇃ':27
  'ᇄ':28
  'ᇅ':29
  'ᇆ':30
  'ᇇ':31
  'ᇈ':32
  'ᇉ':33
  'ᇊ':34
  'ᇋ':35
  'ᇌ':36
  'ᇍ':37
  'ᇎ':38


