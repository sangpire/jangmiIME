require "coffee-script"
keypress = require "keypress"
ime = require "./index.coffee"

stdin = process.stdin
keypress stdin

stdin.resume()
stdin.setEncoding "utf8"
stdin.setRawMode true

stdin.on 'keypress', (ch, key) ->
  process.exit() if key.ctrl and key.name is 'c'
  ime.jamoIn char2JaMap[ch]

char2JaMap =
  q: 'ㅂ'
  Q: 'ㅃ'
  w: 'ㅈ'
  W: 'ㅉ'
  e: 'ㄷ'
  E: 'ㄸ'
  r: 'ㄱ'
  R: 'ㄲ'
  t: 'ㅅ'
  T: 'ㅆ'
  y: 'ㅛ'
  u: 'ㅕ'
  i: 'ㅑ'
  o: 'ㅐ'
  O: 'ㅒ'
  p: 'ㅔ'
  P: 'ㅖ'
  a: 'ㅁ'
  s: 'ㄴ'
  d: 'ㅇ'
  f: 'ㄹ'
  g: 'ㅎ'
  h: 'ㅗ'
  j: 'ㅓ'
  k: 'ㅏ'
  l: 'ㅣ'
  z: 'ㅋ'
  x: 'ㅌ'
  c: 'ㅊ'
  v: 'ㅍ'
  b: 'ㅠ'
  n: 'ㅜ'
  m: 'ㅡ'