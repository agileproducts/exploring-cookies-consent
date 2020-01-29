fs = require 'fs'
yaml = require 'js-yaml'

config = null

parseCookieConfig = (ymlfile) ->
  config = yaml.safeLoad(fs.readFileSync("test/unit/cookies.test.yml"))

cookieConfig = () ->
  return config

module.exports = {
    parseCookieConfig,
    cookieConfig
}