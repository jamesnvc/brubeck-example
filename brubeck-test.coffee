brubeck = require 'brubeck'
fs      = require 'fs'
path    = require 'path'
Mu      = require 'mu'

Mu.templateRoot = './templates'

s = brubeck.createServer
  GET:
    '/': () ->
      @writeHead 200, 'Content-Type': 'text/html'
      ctx =
        pageTitle: 'Index'
        foo: 'The main page'
      Mu.render 'layout.html', ctx, {}, (err, out) =>
        throw err if err
        buffer = []
        out.addListener 'data', (c) -> buffer.push(c)
        out.addListener 'end', =>
          @write buffer.join ''
          @end()
      brubeck.WAIT

s.listen 8080
