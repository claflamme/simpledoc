fs = require 'fs'
path = require 'path'
_ = require 'lodash'
async = require 'async'

module.exports = class Crawler

  constructor: ->

    @tasks = [
      @readWorkingDirectory
      @resolveFilePaths
      @findMarkdownFiles
      @sortMarkdownFiles
      @findStyleFiles
    ]

  styleExtensions: ['css', 'sass', 'scss', 'less', 'styl']

  crawl: (directory, callback) ->

    @directory = directory
    @files = { raw: [], markdown: [], style: [] }

    async.waterfall @tasks, (err) =>
      callback @files

  readWorkingDirectory: (callback) =>

    fs.readdir @directory, (err, files) =>

      @files.raw = files

      callback null

  findMarkdownFiles: (callback) =>

    @files.markdown = @files.raw.filter (filename) =>
      return @hasExtension filename, 'md'

    callback null

  findStyleFiles: (callback) =>

    @files.style = @files.raw.filter (filename) =>
      return @hasExtension filename, @styleExtensions

    callback null

  hasExtension: (filename, validExtensions) ->

    if _.isString validExtensions
      validExtensions = [validExtensions]

    extension = filename.slice (filename.lastIndexOf('.') + 1)

    return validExtensions.indexOf(extension) != -1

  resolveFilePaths: (callback) =>

    @files.raw = @files.raw.map (filename, i) =>
      return path.resolve @directory, filename

    callback null

  sortMarkdownFiles: (callback) =>

    readmeName = 'readme.md'

    @files.markdown.sort (a, b) ->

      # Always sort readme files to the top
      if a.toLowerCase() == readmeName
        return -1
      if b.toLowerCase() == readmeName
        return 1

      # Sort the other filenames alphabetically/numerically
      if a < b
        return -1
      if a > b
        return 1
      return 0

    callback null
