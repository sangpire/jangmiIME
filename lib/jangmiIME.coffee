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
UTF8_START_CODE = 0xAC00

currentHangul = ""

exports.clear = ->
  currentHangul = ""

exports.getCurrentHangul = ->
  currentHangul

class Hangul
  constructor: ->

  setChoSeong: (@choSeong) ->
    console.log "choSeong set as #{@choSeong}"
  setJungSeong: (@jungSeong) ->
    console.log "jung set as #{@jungSeong}"
  setJongSeong: (@jongSeong) ->
    console.log "jongSeong set as #{@jongSeong}"

  isWaitChoSeong: ->
    not @jungSeong
  isWaitJungSeong: ->
    @choSeong and not @jongSeong
  isWaitJongSeong: ->
    @choSeong and @jungSeong

  getJa: ->
    if @choSeong?
      ja = @choSeong
      @choSeong = ""
    if @jungSeong?
      chDiff =  UTF8_START_CODE + (choSeongMap[@choSeong] * 588)
      @jungSeong = ""
    @jongSeong = ""
    return ja

  curJa: ->
    @choSeong

hangul = new Hangul()
inJamo = ""
exports.jamoIn = (jamo) ->

  joHapEnd= ->
    console.log "joHap End"
    inJamo= ""
    hangul.getJa()

  inJamo += jamo
  console.log "inJamo ->#{inJamo}<-"
  if hangul.isWaitChoSeong()
    if choSeongMap.hasOwnProperty inJamo
      hangul.setChoSeong inJamo
      hangul.curJa()
    else
      if jungSeongMap.hasOwnProperty jamo
        if hangul.isWaitJungSeong()
          inJamo = jamo
          hangul.setJungSeong jamo
      else
        joHapEnd()+jamo
  else if hangul.isWaitJungSeong()
  else if hangul.isWaitJongSeong()
  else
    inJamo = ""
    hangul.getJa() +  jamo

#  if choSeongMap.hasOwnProperty inJamo
#    if hangul.isWaitChoSeong()
#      hangul.setChoSeong inJamo
#    else
#      hangul.toChar()
#  else if jungSeongMap.hasOwnProperty inJamo
#    if hangul.isWaitJungSeong()
#      hangul.setJungSeong inJamo
#    else
#      hangul.toChar()
#  else if jongSeongMap.hasOwnProperty inJamo
#    if hangul.isWaitJongSeong()
#      hangul.setJongSeong inJamo
#    else
#      hangul.toChar()
#  if hangul.isChangeStatus()
#    inJamo = ""
#
#  #charCode = jamo.charCodeAt 0
  #currentHangul = String.fromCharCode charCode
  #console.log "jamo:#{jamo}(#{charCode})"
  #console.log "choSeongMap:#{choSeongMap[jamo]}"

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


