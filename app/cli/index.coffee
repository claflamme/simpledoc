path = require 'path'
cmd = require 'commander'
crawler = new (require '../lib/Crawler')
parser = new (require '../lib/Parser')
generator = new (require '../lib/Generator')
server = new (require '../lib/Server')

cmd
.option('-s, --serve', 'Start a server for the generated documentation.')
.option('-f, --from <path>', 'Directory to get the markdown files from.')
.option('-t, --to <path>', 'Directory to output the index.html file to.')
.parse(process.argv)

cwd = process.cwd()

inputDir = cmd.from or cwd
outputDir = cmd.to or cwd
outputFile = path.join outputDir, 'index.html'

crawler.crawl inputDir, (filenames) ->
  parser.parse filenames, (html) ->
    generator.generate html, outputFile, ->

if cmd.serve
  server.serve outputFile
