cmd = require 'commander'
crawler = new (require './lib/Crawler')
parser = new (require './lib/Parser')
generator = new (require './lib/Generator')
server = new (require './lib/Server')

cmd
.option('-s, --serve', 'Start a server for the generated documentation.')
.parse(process.argv)

outputPath = __dirname + '/../index.html'

crawler.crawl __dirname + '/../docs', (filenames) ->
  parser.parse filenames, (html) ->
    generator.generate html, outputPath, ->

if cmd.serve
  server.serve outputPath
