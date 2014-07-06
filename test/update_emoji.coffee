fs = require 'fs'
app = require '../lib/app'
assert = (bool) -> throw new Error('assertion failed') if !bool

module.exports = start: (done) ->
  app.init './emoji'
  app.update true, (err, list) ->
    # right scope?
    assert this == app
    # error?
    throw err if err?
    # list valid?
    assert list instanceof Array
    assert list.length > 100
    assert list.indexOf('wink') >= 0
    # file-system valid?
    assert fs.existsSync './emoji/wink.png'
    assert fs.existsSync './emoji/!index.list'
    # file-system contains valid list?
    assert fs.readFileSync('./emoji/!index.list').toString() == JSON.stringify list
    done()