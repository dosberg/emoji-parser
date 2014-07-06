app = require '../lib/app'
assert = (bool) -> throw new Error('assertion failed') if !bool

module.exports = start: (done) ->
  result = app.parse 'This is a :telephone:', 'http://example.com/emoji/images',
    classes: "emoji someclass"
    attributes:
      title: (name) -> name
      alt: (name) -> ':' + name + ':'
  assert result == "This is a <img class='emoji someclass' src='http://example.com/emoji/images/telephone.png' title='telephone' alt=':telephone:' />"
  done()