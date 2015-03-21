fs = require 'fs'
path = require 'path'
marked = require 'marked'

module.exports = class Parser

  constructor: ->

    @output = ''

  parse: (filenames, callback) ->

    fileOpts = { encoding: 'utf-8' }

    filenames.forEach (filename) =>

      data = fs.readFileSync filename, fileOpts

      className = if filename.toLowerCase() == 'readme.md' then 'readme' else ''

      @output += "<section class='#{className}'>" + marked(data) + '</section>'

    callback @output
