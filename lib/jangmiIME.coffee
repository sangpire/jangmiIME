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

  isWaitChoSeong: ->
    not @jungSeong?
  isWaitJungSeong: ->
    @choSeong? and not @jongSeong?
  isWaitJongSeong: ->
    @choSeong? and @jungSeong?

  add: (jamo) ->
    @curJamo += jamo
    debug """
    \nadded:>#{jamo}< ==> #{@curJamo}
    wait[#{@isWaitChoSeong()}|#{@isWaitJungSeong()}|#{@isWaitJongSeong()}]"
    """
    if @isWaitChoSeong()
      if choSeongMap.hasOwnProperty @curJamo
        @choSeong = @curJamo
      else
        if choSeongMap.hasOwnProperty jamo
          @listener.write @peep()
          @choSeong = @curJamo = jamo
        else if jungSeongMap.hasOwnProperty jamo
          if hangul.isWaitJungSeong()
            @jungSeong = @curJamo = jamo
          else
            if @choSeong?.length > 0
              @listener.write @peep()
              @reset()
            @listener.write jamo
    else if @isWaitJungSeong()
      if jungSeongMap.hasOwnProperty @curJamo
        @jungSeong = @curJamo
      else
        if jongSeongMap.hasOwnProperty jamo
          if hangul.isWaitJongSeong()
            @jongSeong = @curJamo = jamo
          else
            @listener.write @peep()
            @reset()
            @add jamo
    else if @isWaitJongSeong()
      if jongSeongMap.hasOwnProperty @curJamo
        @jongSeong = @curJamo
      else
        if jungSeongMap.hasOwnProperty jamo
          if @jongSeong? and choSeongMap.hasOwnProperty @jongSeong
            @curJamo = jamo
            [temp, @jongSeong]      = [@jongSeong, null]
            @listener.write @peep()
            [@choSeong, @jungSeong] = [temp, @curJamo]
        else
          @listener.write @peep()
          @reset()
          @add jamo
    else
      debug "What situation?"
      @reset()
      @add jamo

  ###
    peep current hangul
  ###
  peep: ->
    debug """
    peep[#{@choSeong}|#{@jungSeong}|#{@jongSeong}]
    peep[#{choSeongMap[@choSeong]}|#{jungSeongMap[@jungSeong]}|#{jongSeongMap[@jongSeong]}]
    """
    if @choSeong? and @jungSeong?
      code = UTF8_START_CODE + choSeongMap[@choSeong] * UTF8_CHOSEONG_DIFF
      code += jungSeongMap[@jungSeong] * UTF8_JUNGSEONG_DIFF
      code += jongSeongMap[@jongSeong] if @jongSeong?
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
  peep = hangul.peep()
  result = if written? then written else ""
  result += if peep? then peep else ""
  written = null
  return result


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


