# Description:
#   Example scripts for you to examine and try out.
#
# Notes:
#   They are commented out by default, because most of them are pretty silly and
#   wouldn't be useful and amusing enough for day to day huboting.
#   Uncomment the ones you want to try and experiment with.
#
#   These are from the scripting documentation: https://github.com/github/hubot/blob/master/docs/scripting.md

#hubot
module.exports = (robot) ->

  #read a file, a list of some response sets
  global.result = []
  global.tmp = []
  fs = require "fs"
  global.readStr = fs.readFileSync "responseList.txt","utf8"
  global.tmp = global.readStr.split("\n")
  for i in [0...global.tmp.length]
    global.result[i] = global.tmp[i].split(",")

  #ask hubot to show list in slack
  robot.respond /show me list/i,(msg)->
    msg.reply global.readStr

  #write file, add a response set to a list in slack
  robot.respond /if i say (.*) you say (.*)/i,(msg) ->
    isWriting = false
    #check if the keyword is already in list
    for j in [0...global.tmp.length-1]
      if global.result[j][0] is msg.match[1]
        isWriting = true
        secondMatch = global.result[j][1]
    if isWriting is false
      #new response!,write on file
      fs = require "fs"
      data = "#{global.readStr}#{msg.match[1]},#{msg.match[2]}\n"
      fs.writeFileSync "responseList.txt", data
    if isWriting is true 
      if secondMatch is msg.match[2]
        #after adding new response
        msg.reply "OK! A#{msg.match[1]} -> #{msg.match[2]} !"
      else
        #existing response!
        msg.reply "#{msg.match[1]} is existing"

  #response according to list
  for j in [0...global.tmp.length-1]
    keyword = eval("/#{global.result[j][0]}/i")
    do(j) ->
      response = global.result[j][1]
      robot.hear keyword,(msg) ->
         msg.reply "#{response}"

