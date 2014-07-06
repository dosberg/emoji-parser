path = require 'path'
fs = require 'fs'

tests = fs.readdirSync path.dirname module.filename

tests.splice tests.indexOf(path.basename module.filename), 1

if tests.length
  i = 0
  trigger = (test) ->
    return if !test
    console.info "-----------\nTEST: #{test}"
    require("./#{test}")?.start ->
      console.info "succeeded."
      trigger tests[++i]
  trigger tests[i]