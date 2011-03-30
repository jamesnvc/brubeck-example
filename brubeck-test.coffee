brubeck = require 'brubeck'
fs      = require 'fs'
path    = require 'path'
Mu      = require 'mu'

Mu.templateRoot = './templates'
for template in fs.readdirSync(Mu.templateRoot)
  Mu.compile path.basename(template), ->

s = brubeck.createServer
  GET:
    '/': () ->
      ctx =
        pageTitle: 'Index'
        foo: 'The main page'
      write = @write
      Mu.render 'layout.html', ctx, {}, (err, out) ->
        throw err if err
        buffer = []
        out.addListener 'data', (c) -> buffer.push(c)
        out.addListener 'end', -> write buffer.join ''

s.listen 8080
