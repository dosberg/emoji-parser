app = require '../lib/app'
assert = (bool) -> throw new Error('assertion failed') if !bool

module.exports = start: (done) ->
  # no title, own classes
  result = app.parse 'This is a :telephone:', 'http://example.com/emoji/images',
    classes: "emoji someclass"
    attributes:
      alt: (name) -> ':' + name + ':'
  assert result == "This is a <img class='emoji someclass' src='http://example.com/emoji/images/telephone.png' alt=':telephone:' />"

  # simple call without any options
  result = app.parse 'This is a :+1:, this a :-1:', 'http://example.com/emoji/images'
  assert result == "This is a <img class='emoji' src='http://example.com/emoji/images/%2B1.png' title='+1' alt=':+1:' />, this a <img class='emoji' src='http://example.com/emoji/images/-1.png' title='-1' alt=':-1:' />"

  # lets pass a own parser-function
  result = app.parse 'This is a :+1:, this a :-1:', 'http://example.com/emoji/images', (name, url, classes, options) ->
    '"' + url + '/' + name + '.png' + '"'
  assert result == 'This is a "http://example.com/emoji/images/+1.png", this a "http://example.com/emoji/images/-1.png"'

  # lets try to change the list.
  result = app.parse 'This is a :+1:, this a :-1:', 'http://example.com/emoji/images', list: []
  assert result == 'This is a :+1:, this a :-1:'

  # since list gets saved after each call it's empty now.
  result = app.parse 'This is a :+1:, this a :-1:', 'http://example.com/emoji/images'
  assert result == "This is a :+1:, this a :-1:"

  done()