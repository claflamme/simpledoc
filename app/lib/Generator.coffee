fs = require 'fs'
path = require 'path'
jade = require 'jade'
cheerio = require 'cheerio'
less = require 'less'

module.exports = class Generator

  constructor: ->

  getCss: (callback) ->

    opts = { encoding: 'utf-8' }

    lessPath = path.join __dirname, '../theme/main.less'
    lessSrc = fs.readFileSync lessPath, opts

    less.render lessSrc, { filename: lessPath }, (err, output) ->

      if err
        console.error err

      callback output.css

  getJs: (folder) ->

    basePath = path.join(__dirname, '../theme/js/', folder)
    filenames = fs.readdirSync basePath
    opts = { encoding: 'utf-8' }
    js = ''

    filenames.forEach (filename) ->
      js += fs.readFileSync path.join(basePath, filename), opts

    return js

  generate: (html, outputPath, callback) ->

    jsVendor = @getJs('vendor')
    jsLib = @getJs('lib')

    @getCss (css) ->

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
        jsVendor: jsVendor
        jsLib: jsLib
        updated: new Date().toString()

      html = jade.renderFile __dirname + '/../theme/main.jade', templateVars

      fs.writeFileSync outputPath, html

      callback()
