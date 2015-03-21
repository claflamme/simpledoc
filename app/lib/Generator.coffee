fs = require 'fs'
path = require 'path'
jade = require 'jade'
cheerio = require 'cheerio'

module.exports = class Generator

  constructor: ->

  getCss: ->

    opts =
      encoding: 'utf-8'

    return fs.readFileSync path.join(__dirname, '../static/style.css'), opts

  generate: (html, outputPath, callback) ->

    css = @getCss()

    $ = cheerio.load html

    headers = []

    $('h1, h2, h3, h4, h5, h6').each (i, header) ->

      header =
        text: $(this).text()
        type: header.name
        anchor: '#' + $(this).attr('id')

      headers.push header

    templateVars =
      pretty: true
      content: html
      headers: headers
      css: css
      updated: new Date().toString()

    html = jade.renderFile __dirname + '/../static/main.jade', templateVars

    fs.writeFileSync outputPath, html

    callback()
