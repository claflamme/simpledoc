path = require 'path'
express = require 'express'

module.exports = class Server

  constructor: ->

    @app = express()
    @app.set 'port', process.env.PORT || 3000

  serve: (fileName) ->

    @app.get '/', (req, res) ->
      res.sendFile path.resolve(fileName)

    server = @app.listen @app.get('port'), ->

      address = server.address()

      if address.host = '::'
        address.host = '127.0.0.1'

      console.log 'Serving to http://%s:%s', address.host, address.port, '\n'
