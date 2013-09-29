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

exports.jamoIn = (jamo) ->
  charCode = jamo.charCodeAt 0
  console.log "jamo:#{jamo}(#{charCode})"
  console.log "choSeongMap:#{choSeongMap[jamo]}"

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
  'ᅡ':0
  'ᅢ':1
  'ᅣ':2
  'ᅤ':3
  'ᅥ':4
  'ᅦ':5
  'ᅧ':6
  'ᅨ':7
  'ᅩ':8
  'ᅪ':9
  'ᅫ':10
  'ᅬ':11
  'ᅭ':12
  'ᅮ':13
  'ᅯ':14
  'ᅰ':15
  'ᅱ':16
  'ᅲ':17
  'ᅳ':18
  'ᅴ':19
  'ᅵ':20

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


