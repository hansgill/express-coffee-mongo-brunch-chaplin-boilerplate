mongoose    = require "mongoose"
Schema      = mongoose.Schema
_           = require "underscore"
async       = require "async"
AmazonSES = require "amazon-ses"
sysutils    = require '../sysutils'
conf = require "../conf"
uuid = require "node-uuid"
#modelContext = require './model-context'

getModel = (name) ->
  ###
  Dynamically pulls the _Mongoose Model_, useful if you want to reference a _function_ declared
  as a `methods` or `statics` instance within another `method` or `static` function declaration.
  ###
  mongoose.model name
# User document
User = new Schema
  firstName:
    type: String
  lastName:
    type: String
  email:
    type: String
  password:
    type: String
  monthlyDonation:
    type: Number
  donationPerCampaign:
    type: Number
    default: 10
  monthlyLeft:
    type: Number

User.virtual('id').get () ->
  return this._id.toHexString()

# register model
mongoose.model('User', User)

# and export the model
module.exports.User = mongoose.model 'User'
