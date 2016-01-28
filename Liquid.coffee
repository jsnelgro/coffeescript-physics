Actor = require './Actor'

class Liquid extends Actor

  tags: { liquid: true }

  constructor: (params={position, velocity, acceleration, mass, width, height})->
    @physics = false
    @width = 200
    @height = 200
    @coefficent = 0.1
    super(params)

  display: ->
    noStroke()
    fill(175, 25, 140)
    rect(@position.x, @position.y, @width, @height)

module.exports = Liquid
