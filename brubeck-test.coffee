brubeck = require 'brubeck'
fs      = require 'fs'
path    = require 'path'

brubeck.templating.templateRoot = './templates'

s = brubeck.createServer
  GET:
    '/': () ->
      @writeHead 200, 'Content-Type': 'text/html'
      @render 'main.html',
        pageTitle: 'Index'
        foo: 'The main page'

s.listen 8080
