fs = require 'fs'
update = require './update'

service = module.exports

dirName = null
emoji = service.emoji = []
test = /\:[a-z0-9_+-]+\:/g

service.init = (dir = dirName || require('path').dirname(module.filename) + '/emoji') ->
  dirName = dir
  try
    data = fs.readFileSync "#{dir}/!index.list", encoding: 'UTF8'
    emoji = service.emoji = JSON.parse data if data?
  service

save = (cb) ->
  fs.writeFile "#{dirName}/!index.list", JSON.stringify(emoji), cb
  service

service.update = (remain, cb) ->
  if typeof remain == 'function'
    cb = remain
    remain = true
  if dirName?
    update.call this, dirName, remain, (err, list) ->
      save emoji = service.emoji = list if list? && list instanceof Array
      cb?.call?(service, err, list)
  else
    cb?.call?(service, 'not initialized')
  service

service.parse = (string, url, options = {}) ->
  parser = null
  if typeof options == 'function'
    parser = options
  else
    if !options.attributes?
      options.attributes =
        title: (name) -> name
        alt: (name) -> ":#{name}:"
    classes = if options.classes? then options.classes else "emoji"
    parser = (name) ->
      res = "<img class='#{classes}' src='#{url}/#{encodeURIComponent name}.png' "
      res += "#{key}='#{val name}' " for key, val of options.attributes
      res + '/>'
  string.replace test, (match) ->
    name = match.slice 1, -1
    return match if emoji.indexOf(name) == -1
    parser name