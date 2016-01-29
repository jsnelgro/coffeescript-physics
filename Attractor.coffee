Actor = require './Actor'
Vector = require './Vector'

class Attractor extends Actor

  constructor: (params) ->
    super params
    @mass = params.mass || 20
    @G = 1

module.exports = Attractor
