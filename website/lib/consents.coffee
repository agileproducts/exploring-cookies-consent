mask = require './mask.coffee'

# convert the choices indicated in the consent form into a bitmask
# when encoded this way around the most significant bit is always 1 so get fully padded array
qsParser = (object, callback) ->
    consentCode = mask.create([object.optIn?, object.optOut?, object.necessary?])
    callback(consentCode)

readCode = (code, callback) ->
  arr = mask.decode(code)
  consentObj = {}
  consentObj.necessary = true
  if arr[1] is true then consentObj.optOut = true
  if arr[0] is true then consentObj.optIn = true
  callback(consentObj)

module.exports = { qsParser, readCode }