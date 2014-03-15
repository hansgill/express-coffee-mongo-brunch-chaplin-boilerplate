fs              = require 'fs'
express         = require "express"
url             = require "url"
sysutils        = require '../../shared/sysutils'
async           = require "async"
conf            = require "../../shared/conf"
http            = require 'http'
passport        = require 'passport'
BearerStrategy  = require("passport-http-bearer").Strategy

############################################################################
# authentication routes
# Sets up basic authentication and protects the /api/* routes with a token
############################################################################

module.exports = (app) ->
  if conf.get("protectAPI")
    #make sure all the api calls are authenticated with a user token
    app.all "/api/*", passport.authenticate('bearer', { session: false })

    #token based api authentication
    passport.use new BearerStrategy {} ,(token, done)->
      process.nextTick ()->
        #find user
        #if user is not found return false
        #return done(null, false)
        #return user and this api call is validated.
        #return done(null, user)
        return done(null,true)

  if conf.get("enableBasicAuth")
    basicAuth = express.basicAuth (email, password, callback)->
      #find user and based on email and password.
      return callback null
      #return callback err,user

    app.get "/auth/login", basicAuth, (req,res)->
      #this user comes from express.basicAuth call above.
      res.send
        token : req.user.token

    app.get "/auth/logout", (req,res)->
      console.log "logout"
      req.session.destroy()
      res.redirect "/"