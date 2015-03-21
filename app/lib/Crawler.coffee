fs = require 'fs'
path = require 'path'

module.exports = class Crawler

  constructor: ->

    @output = ''

  crawl: (directory, callback) ->

    @directory = directory

    fs.readdir @directory, (err, files) =>
      files = @filterMarkdown files
      files = @resolveFilePaths files
      files = @sortFileList files
      callback files

  isMarkdownFile: (filename) ->

    extension = filename.split('.').pop()

    return extension == 'md'

  filterMarkdown: (fileNames) =>

    return fileNames.filter (fileName) =>
      return @isMarkdownFile fileName

  sortFileList: (fileNames) ->

    readmeName = 'readme.md'

    fileNames.sort (a, b) ->

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

    return fileNames

  resolveFilePaths: (filenames) =>

    filenames.forEach (filename, i) =>
      filenames[i] = path.resolve @directory, filename

    return filenames
