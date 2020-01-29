#core modules
path = require 'path'
fs = require 'fs'

#npm install
express = require 'express'
cookieParser = require 'cookie-parser'
expressHandlebars = require 'express-handlebars'
handlebars = require 'handlebars'
yaml = require 'js-yaml'

cookieBanner = require('./lib/cookie-banner.coffee')
cookieSetter = require('./lib/cookie-setter.coffee')
consents = require('./lib/consents.coffee')
secret = "donkeyfuck"

# configuration for template engine
# which is more pernickerty than you'd expect
handlebarsEngineConfig = {
  handlebars: handlebars,
  extname: '.hbs',
  partialsDir: './views', #it's otherwise opinionated
  defaultLayout: false
}

# create an instance of the template engine with this config
handlebarsInstance = expressHandlebars.create(handlebarsEngineConfig)

# cookie consent configuration
cookieConfig = yaml.safeLoad(fs.readFileSync("cookies.yml"))

# create express app
app = express()

# set up viewing and templating
app.engine('hbs', handlebarsInstance.engine)
app.set('view engine', 'hbs')
app.set('views', './views')

#middleware
app.use express.static(path.join(__dirname, 'public'))
app.use cookieParser(secret)
app.use cookieBanner(cookieConfig)
app.use cookieSetter


#homepage
app.get '/', (req, res) ->
  res.status 200
  consent = if req.cookies.cst then true else false
  res.render 'home', { "cookieConfig": cookieConfig, "cookies": req.cookies, "consent": consent }

app.get '/consent', (req, res) ->
  consents.qsParser req.query, (consentCode) ->
    res.cookie('cst', consentCode)
    res.redirect('/')

app.get '/consent/manage', (req, res) ->
  cookieConfig = req.cookieConfig
  res.render 'consent-manage', { "cookieConfig": cookieConfig }
  #needs to read and reflect what is actually set

port = process.env.PORT || 3000
app.listen port
console.log("running on port " + port)

#redirect 404s home
app.use (req, res, next) ->
  res.status(404).redirect('/')

module.exports = app

