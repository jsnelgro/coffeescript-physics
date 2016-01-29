Vector = require './Vector'

class Actor

  physics: true
  solid: true # TODO
  tags: {} # TODO

  constructor: ({position, velocity, acceleration, mass, width, height, angle, angularVelocity, angularAcceleration}) ->
    @position = position || new Vector(x:0,y:0)
    @velocity = velocity || new Vector(x:0,y:0)
    @acceleration = acceleration || new Vector(x:0,y:0)
    @mass = mass || 1
    @width = width || 50
    @height = height || 50
    @angle = angle || 0
    @angularVelocity = angularVelocity || 0
    @angularAcceleration = angularAcceleration || 0

  update: ->
    if @physics then @accelerate(@acceleration)

  display: ->
    @angle = @direction()
    P.fill(0,0,0)
    P.rectMode(P.CENTER)
    P.pushMatrix()
    P.translate(@position.x, @position.y)
    P.rotate(@angle)
    P.rect(0, 0, @width, @height/2)
    P.popMatrix()

  applyForce: (force)->
    f = force.copy()
    f.divide(@mass)
    @acceleration.add(f)

  calculateAttraction: (actor)->
    dir = Vector.subtract(@position, actor.position)
    distance = P.constrain(dir.magnitude(), 25, 5)
    dir.normalize()
    mag = (1 * @mass * actor.mass) / distance**2
    return Vector.multiply(dir, mag)

  repel: (actor)->
    dir = Vector.add(@position, actor.position)
    distance = P.constrain(dir.magnitude(), 25, 5)
    dir.normalize()
    mag = (1 * @mass * actor.mass) / distance**2
    return Vector.multiply(dir, mag)

  clearForces: ->
    @acceleration.multiply(0)

  accelerate: (accel_vector)->
    @velocity.add(accel_vector)
    @velocity.limit(10)
    @position.add(@velocity)
    @angularVelocity += @angularAcceleration
    @angle += @angularVelocity
    @clearForces()

  direction: ->
    return @velocity.heading()

  contains: (actor)->
    actpos = actor.position
    return actpos.x > @position.x &&
           actpos.x < @position.x + @width &&
           actpos.y > @position.y &&
           actpos.y < @position.y + @height


module.exports = Actor
