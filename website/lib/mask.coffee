create = (booleanArray) ->
  mask = 0
  mask |= bool << index++ for bool, index in booleanArray
  mask

decode = (number) ->
  booleanArray = []
  nShifted = number
  pushAndShift = (a, n) ->
    a.push(Boolean(nShifted &1))
    nShifted >>>= 1
  pushAndShift(booleanArray, nShifted) while nShifted > 0
  booleanArray

#see: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Bitwise_Operators

module.exports = { create, decode }

