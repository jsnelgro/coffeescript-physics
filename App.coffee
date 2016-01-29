World = require './World'

class App

  constructor: (P)->
    window.P = P

  setup: ->
    P.size(window.innerWidth, window.innerHeight)
    P.angleMode = 'radians'
    @world = new World()

  draw: ->
    P.background(255,255,255)
    @world.update()
    @world.display()

  mousePressed: ->
    return

  handleMousePressed: ->
    @world.mousePressed()

module.exports = App
