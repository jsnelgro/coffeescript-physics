World = require './World'
window.p5 = require 'p5'

class App

  setup: ->
    createCanvas(640, 480)
    @world = new World()

  draw: ->
    background(255,255,255)
    @world.update()

  mousePressed: ->
    return

  handleMousePressed: ->
    @world.mousePressed()

module.exports = App
