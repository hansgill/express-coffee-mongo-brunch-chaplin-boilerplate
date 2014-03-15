#
# Module dependencies.
#
express     = require 'express'
conf        = require "../shared/conf"
app         = express()
server      = require('http').createServer app
MongoStore  = require('connect-mongo')(express)
cons        = require("consolidate")
passport    = require "passport"

app.configure () ->
  app.engine '.html', cons.ejs
  app.engine '.json', cons.ejs
  app.set 'views', __dirname + '/views'
  app.set 'view engine', 'html'
  app.use passport.initialize()
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use express.static __dirname + '/public'
  app.use express.cookieParser()
  app.use express.session
    secret: 'hackathon'
    maxAge: new Date(Date.now() + 36000000000)
    store: new MongoStore
      db: 'connect-mongo-store'
      host: 'localhost'
      collection: 'sessions'
    cookie:
      expires: new Date(Date.now() + 36000000000)
  app.use app.router


app.configure 'development', () ->
  #app.use(express.errorHandler());
  app.use express.errorHandler { dumpExceptions: true, showStack: true }

# connect the db
require "../shared/models/mongo"

(require './boot-routes') app

printArt = () ->
  v = conf.get "version"
  console.log "Starting ".green + "#{conf.get "app_id"}".green.italic
  
module.exports =
  start: (callback) ->
    #start server
    server.listen conf.get("port"), () ->
      printArt()
      console.log "#{conf.get "app_id"} app server listening on port %d in %s mode" , conf.get("port"), conf.get("NODE_ENV")
      callback() if callback

  stop: (callback) ->
    #start server
    server.close () ->
      console.log "#{conf.get "app_id"} app server shutting down"
      callback() if callback

