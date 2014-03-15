#!/usr/bin/env node

#example of a script you can put in here.
#these scripts must be compiled manually (coffee -c [script-name])

util = require("util")
mongoose = require("mongoose")
async = require("async")
ObjectId = mongoose.Types.ObjectId

console.log("Bootstrap: Connecting to DB")

# connect to db
connCb = (err)->
  if(err)
    return console.log("Post Install Bootstrap: Error connecting to Mongo - " + err)
  console.log("Bootstrap: Connected API to Mongo")

# setup mongo
db = require("../lib/shared/models/mongo");

# Bootstrap models
Campaign = require("../lib/shared/models/campaign").Campaign;

campaigns = [
  {
    "name":"Ryan S. Brown",
    "title":"The Bre Project - the life of a young girl fighting cancer",
    "description":"What I am asking for is funding that will allow me the
    time I need to concentrate my efforts on finalizing these works.
    These funds will help cover my living expenses as I paint, as well as
    provide me with the budget necessary to advertise and promote the
    exhibition.  Some of the funding will also be going towards framing
    the works and transporting the works to the exhibition space. ",
    "pics":["Ryan1.jpg"],
    "amountNeeded":45000,
    "amountFunded":2069,
    "deadline":'12/28/2013 15:57'
  },

  {
    "name":"Mary",
    "title":"Help Mary pay for surgery.",
    "description":"A few days ago, Mary was knocked over by a motorcycle
    driver who sped off, leaving her with a fractured wrist. Mary and her
    husband used up all their savings just to get Mary se...",
    "pics":["Mary1.jpg"],
    "amountNeeded":10000,
    "amountFunded":655
    "deadline":'12/30/2013 22:57'
  },

  {
    "name":"Ashok",
    "title":"Ashok needs surgery to enhance functionality in his hand.",
    "description":"For $1,225, we can fund Ashok’s surgery so he can be
    able to use his left hand again and pursue his dream of becoming a
    teacher!
    100% of your donation funds treatment for the person you choose and we
    are committed to complete transparency and accountability.",
    "pics":["Ashok1.jpg"],
    "amountNeeded":1225,
    "amountFunded":400
    "deadline":'01/02/2014 08:57'
  },

  {
    "name":"Arun",
    "title":"Arun needs surgery to repair a post-burn scar contracture on
    his right hand and chest.",
    "description":"Nine months ago, two-year-old Arun fell over a hot pot
    of lentils and suffered burns on his right hand and on his chest. The
    burns have now turned into scar contractures which limit his mobility
    and cause him constant discomfort. Sometimes in the night, Arun is
    unable to fall asleep because of the severe pain. In the future,
    Arun’s mother “wants him to be a health assistant.” For $1,415, we can
    fund Arun’s surgery so he can grow up to be a healthy and strong
    man!",
    "pics":["Arun1.jpg"],
    "amountNeeded":1415
    "amountFunded":1280
    "deadline":'03/15/2014 11:00'
  }
]

addCampaign = (campaign, callback)->
  Campaign.update {name:campaign.name}, {$set:campaign}, {upsert: true}, (err)->
    callback()

cleanup = ()->
  console.log("Bootstrap: disconnecting from mongo")
  mongoose.disconnect()

async.forEach campaigns, addCampaign, (err)->
  cleanup()
