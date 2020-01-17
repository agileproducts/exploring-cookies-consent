consents = require './consents.coffee'

module.exports = (req, res, next) ->
  cst = req.cookies.cst ? 4
  
  consents.readCode cst, (consentsObj) ->
    # coffeelint: disable=max_line_length
    res.cookie('nsc', "necessary cookie " + Math.random()) if ! req.cookies.nsc and consentsObj.necessary is true
    res.cookie('opc',  "opt-out cookie " + Math.random()) if ! req.cookies.opc and consentsObj.optOut is true
    res.cookie('ipc',  "opt-in cookie " + Math.random()) if ! req.cookies.ipc and consentsObj.optIn is true
    # coffeelint: enable=max_line_length
    next()
    