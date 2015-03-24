fs = require 'fs'
path = require 'path'
marked = require 'marked'
highlight = require 'highlight.js'

module.exports = class Parser

  constructor: ->

    @output = ''

  parse: (filenames, callback) ->

    fileOpts = { encoding: 'utf-8' }
    marked.setOptions { highlight: @highlight }

    filenames.forEach (filename) =>
      data = fs.readFileSync filename, fileOpts
      className = if filename.toLowerCase() == 'readme.md' then 'readme' else ''
      @output += "<section class='#{className}'>" + marked(data) + '</section>'

    callback @output

  highlight: (code) ->
    return highlight.highlightAuto(code).value
