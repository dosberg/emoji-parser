https = require 'https'
fs = require 'fs'
wrench = require 'wrench'

headers = 'User-Agent': 'frissdiegurke/emoji-parser'

fetchImage = (target, path, name, cb) ->
  file = target + name
  fs.exists file, (bool) ->
    return cb name if bool
    req = https.get
      hostname: 'raw.githubusercontent.com'
      path: "/arvida/emoji-cheat-sheet.com/master/#{path}"
      headers: headers
    , (res) ->
      data = ''
      res.setEncoding 'binary'
      res.on 'data', (chunk) -> data += chunk
      res.on 'end', -> fs.writeFile file, data, 'binary', (err) ->
        if err
          console.warn 'emoji-parser: failed to fetch ' + name
          return cb()
        cb name
    req.on 'error', ->
      console.warn 'emoji-parser: failed to fetch ' + name
      cb()
    req.end()

fetchImages = (target, images, cb) ->
  amount = images.length
  list = []
  done = (name) ->
    list.push name.substring 0, name.length - 4 if name?
    cb list if !--amount
  fetchImage target, image.path, image.name, done for image in images

module.exports = (dir, remain, cb) ->
  dir += '/' if dir[dir.length - 1] != '/'
  wrench.rmdirSyncRecursive dir, true if !remain
  wrench.mkdirSyncRecursive dir
  req = https.get
    hostname: 'api.github.com'
    path: '/repos/arvida/emoji-cheat-sheet.com/contents/public/graphics/emojis'
    headers: headers
  , (res) ->
    data = ''
    res.on 'data', (chunk) -> data += chunk
    res.on 'end', -> fetchImages dir, JSON.parse(data), (images) -> cb null, images
  req.on 'error', cb
  req.end()