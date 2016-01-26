Vector = require './Vector'

class Actor

  physics: true

  constructor: ({position, velocity, acceleration, mass}) ->
    @position = position || new Vector(x:0,y:0)
    @velocity = velocity || new Vector(x:0,y:0)
    @acceleration = acceleration || new Vector(x:0,y:0)
    @mass = mass || 1
    @display()
    @accelerate(@acceleration)

  update: ->
    if @physics then @accelerate(@acceleration)

  display: ->
    ellipse(@position.x, @position.y, 50, 50)

  applyForce: (force)->
    f = force.copy()
    f.divide(@mass)
    @acceleration.add(f)

  clearForces: ->
    @acceleration.multiply(0)

  accelerate: (accel_vector)->
    @velocity.add(accel_vector)
    @position.add(@velocity)
    @clearForces()

module.exports = Actor
