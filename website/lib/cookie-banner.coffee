module.exports = (cookieConfig) ->
  (req, res, next) ->
    req.cookieConfig = cookieConfig
    next()
