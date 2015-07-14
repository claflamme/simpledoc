fs = require 'fs'
path = require 'path'
_ = require 'lodash'
async = require 'async'

module.exports = class Crawler

  constructor: ->

    @tasks = [
      @readWorkingDirectory
      @readThemeDirectory
      @resolveFilePaths
      @findMarkdownFiles
      @sortMarkdownFiles
    ]

  styleExtensions: ['css', 'less', 'stylus']
  templateExtensions: ['jade']

  userThemeDir: '_theme'

  crawl: (directory, callback) ->

    @directory = directory
    @files = raw: [], markdown: [], style: '', template: ''

    async.waterfall @tasks, (err) =>
      callback @files

  readWorkingDirectory: (callback) =>

    fs.readdir @directory, (err, files) =>

      @files.raw = files

      callback null

  readThemeDirectory: (callback) =>

    userDir = path.resolve @directory, @userThemeDir
    dir = path.join __dirname, 'theme'

    fs.lstat userDir, (err, stats) =>
      unless err or !stats.isDirectory()
        dir = userDir
      @fetchThemeFiles dir, callback

  fetchThemeFiles: (dir, callback) =>

    fs.readdir dir, (err, files) =>

      @files.raw.forEach (filename) =>
        @filterFile filename

      callback null

  filterFile: (filename) ->

    unless filename.slice(0, filename.lastIndexOf('.')) == 'main'
      return true
    if @hasExtension(@styleExtensions)
      @files.style.push filename
    else if @hasExtension(@templateExtensions)
      @files.template.push filename

  findMarkdownFiles: (callback) =>

    @files.markdown = @files.raw.filter (filename) =>
      return @hasExtension filename, 'md'

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
