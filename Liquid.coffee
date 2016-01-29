Actor = require './Actor'

class Liquid extends Actor

  tags: { liquid: true }

  constructor: (params)->
    super params
    @physics = false
    @width = params.width || 200
    @height = params.height || 200
    @coefficent = 0.1

  display: ->
    P.rectMode(P.CORNER)
    P.noStroke()
    P.fill(175, 25, 140)
    P.rect(@position.x, @position.y, @width, @height)

module.exports = Liquid
