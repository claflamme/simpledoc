fs = require 'fs'
path = require 'path'
_ = require 'lodash'

module.exports = class Crawler

  constructor: ->

  crawl: (directory, callback) ->

    @directory = directory

    fs.readdir @directory, (err, files) =>
      files = @filterMarkdown files
      files = @sortFileList files
      files = @resolveFilePaths files
      callback files

  hasExtension: (filename, validExtensions) ->

    if _.isString validExtensions
      validExtensions = [validExtensions]

    extension = filename.split('.').pop()

    return validExtensions.indexOf(extension) != -1

  filterMarkdown: (fileNames) =>

    return fileNames.filter (fileName) =>
      return @hasExtension fileName, 'md'

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
