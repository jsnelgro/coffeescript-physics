Vector = require './Vector'

class Actor

  physics: true
  solid: true # TODO
  tags: {} # TODO

  constructor: ({position, velocity, acceleration, mass, width, height}) ->
    @position = position || new Vector(x:0,y:0)
    @velocity = velocity || new Vector(x:0,y:0)
    @acceleration = acceleration || new Vector(x:0,y:0)
    @mass = mass || 1
    @width = width || 50
    @height = height || 50
    @display()
    @accelerate(@acceleration)

  update: ->
    if @physics then @accelerate(@acceleration)

  display: ->
    fill(0,0,0)
    ellipse(@position.x, @position.y, @width, @height)

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

  contains: (actor)->
    actpos = actor.position
    return actpos.x > @position.x &&
           actpos.x < @position.x + @width &&
           actpos.y > @position.y &&
           actpos.y < @position.y + @height


module.exports = Actor
