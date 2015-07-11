path = require 'path'
cmd = require 'commander'
SimpleDoc = require '../module'

server = new (require '../lib/Server')

cmd
.option('-s, --serve', 'Start a server for the generated documentation.')
.option('-f, --from <path>', 'Directory to get the markdown files from.')
.option('-t, --to <path>', 'Directory to output the index.html file to.')
.parse(process.argv)

cwd = process.cwd()

inputDir = cmd.from or cwd
outputDir = cmd.to or cwd

SimpleDoc.render inputDir, outputDir, ->
  console.log 'finished!'

if cmd.serve
  server.serve outputFile
