crawler = new (require '../lib/Crawler')
parser = new (require '../lib/Parser')
generator = new (require '../lib/Generator')

module.exports = new class SimpleDocModule

  constructor: ->

  render: (inputDir, outputDir, callback) ->

    crawler.crawl inputDir, (filenames) ->
      parser.parse filenames, (html) ->
        generator.generate html, outputDir + '/index.html', callback
