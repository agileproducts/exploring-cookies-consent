assert = require('assert')
consents = require('../../lib/consents.coffee')

necessary = { necessary: true }
necessaryOptOut = { necessary: true, optOut: true }
necessaryOptOutOptIn = { necessary: true, optOut: true, optIn: true }

describe 'parsing the consent querysting object', () ->

  it 'should turn necessary into 4', (done) ->
    consents.qsParser necessary, (consentCode) ->
      assert.equal(consentCode, 4) #i.e. 100
      done()

  it 'should turn necessary + optOut into 6', (done) ->
    consents.qsParser necessaryOptOut, (consentCode) ->
      assert.equal(consentCode, 6) #i.e. 110
      done()

  it 'should turn necessary + optOut + optIn into 7', (done) ->
    consents.qsParser necessaryOptOutOptIn, (consentCode) ->
      assert.equal(consentCode, 7) #i.e. 111
      done()


describe 'turning the consent code back into an object', () ->

  it 'should convert 4 back into necessary', (done) ->
    consents.readCode 4, (consentsObj) ->
      assert.deepEqual(consentsObj, necessary)
      done()

  it 'should convert 6 back into necessary + optOut', (done) ->
    consents.readCode 6, (consentsObj) ->
      assert.deepEqual(consentsObj, necessaryOptOut)
      done()

  it 'should convert 7 back into necessary + optOut + optIn', (done) ->
    consents.readCode 7, (consentsObj) ->
      assert.deepEqual(consentsObj, necessaryOptOutOptIn)
      done()
