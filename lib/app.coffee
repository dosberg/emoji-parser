fs = require 'fs'
update = require './update'
parse = require './parse'

service = module.exports

dirName = null
emoji = service.emoji = undefined

service.init = (dir = dirName || require('path').dirname(module.filename) + '/emoji') ->
  dirName = dir
  try
    data = fs.readFileSync "#{dir}/!index.list", encoding: 'UTF8'
    emoji = service.emoji = JSON.parse data if data?
  emoji = service.emoji = emoji || [] # empty list if not existent yet
  service

save = (cb) -> fs.writeFile "#{dirName}/!index.list", JSON.stringify(emoji), cb

service.update = (remain, token, cb) ->
  if typeof token == 'function'
    cb = token
    token = null
  else if typeof remain == 'function'
    cb = remain
    remain = true
    token = null
  if typeof remain == 'string'
    token = remain
    remain = true
  else
    remain = remain != false
  if dirName?
    update.call this, dirName, remain, token, (err, list) ->
      if list? && list instanceof Array
        emoji = service.emoji = list
        save -> cb?.call?(service, err, list)
      else
        cb?.call?(service, err, list)
  else
    cb?.call?(service, 'not initialized')
  service

service.list = parse.list

service.parse = (text, url, options = {}) ->
  options.list = options.list || emoji
  parse text, url, options