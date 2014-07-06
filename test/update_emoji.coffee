app = require '../lib/app'
assert = (bool) -> throw new Error('assertion failed') if !bool

module.exports = start: (done) ->
  app.init './emoji'
  app.update false, (err, list) ->
    assert this == app
    assert !err?
    assert list instanceof Array
    done()