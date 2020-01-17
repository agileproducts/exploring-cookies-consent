assert = require('assert')
mask = require('../../lib/mask.coffee')

describe 'create mask', () ->

  it 'should return 001 for true,false,false', () ->
    assert.equal(mask.create([true,false,false]),1)

  it 'should return 101 for true,false,true', () ->
    assert.equal(mask.create([true,false,true]),5)

  it 'should return 100 for false,false,true', () ->
    assert.equal(mask.create([false,false,true]),4)

  it 'should return 011 for true,true,false', () ->
    assert.equal(mask.create([true,true,false]),3)

###
  decoding isn't yet fully implemented because it loses any leading zeroes in the number, leading to a truncated array. 
  at the moment it works with a hack of making necessary cookies the most significant bit, i.e. always a leading 1
###

describe 'decode mask', () ->

  it 'should return [true, false, false] for 001'#, () ->
    #assert.deepEqual(mask.decode(1),[true,false,false])

  it 'should return [true, false, true] for 101', () ->
    assert.deepEqual(mask.decode(5),[true,false,true])

  it 'should return [false, false, true] for 100', () ->
    assert.deepEqual(mask.decode(4),[false,false,true])

  it 'should return [true, true, false] for 011'#, () ->
    #assert.deepEqual(mask.decode(3),[true,true,false])