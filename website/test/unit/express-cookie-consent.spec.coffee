assert = require 'assert'
yaml = require 'js-yaml'
expressCookieConsent = require '../../lib/express-cookie-consent.coffee'

describe '#cookieConfig', () ->

  cc = null

  before () ->
    expressCookieConsent.parseCookieConfig('cookies.test.yml')
    cc = expressCookieConsent.cookieConfig()

  it 'should return a banner heading and text', (done) ->
    assert.equal(cc.banner.heading, 'TEST BANNER HEADING')
    assert.equal(cc.banner.text, 'Test banner text.')
    done()

  it 'should have a group of necessary cookies'