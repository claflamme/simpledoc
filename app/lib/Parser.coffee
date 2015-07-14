fs = require 'fs'
path = require 'path'
marked = require 'marked'
highlight = require 'highlight.js'
async = require 'async'
config = require './Config'

module.exports = class Parser

  constructor: ->

    @output = { markdown: [], css: [] }
    marked.setOptions { highlight: @highlight }

  parse: (filenames, callback) ->

    async.eachSeries filenames.markdown, @getMarkdownFileAsHtml, (err) =>
      @output.markdown = @output.markdown.map (section) ->
        return "<section>#{section}</section>"
      callback @output

  getMarkdownFileAsHtml: (filename, callback) =>

    data = fs.readFile filename, config.readFileOpts, (err, data) =>
      @output.markdown.push marked(data)
      callback()

  highlight: (code) ->
    return highlight.highlightAuto(code).value
