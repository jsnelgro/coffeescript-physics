Vector = require './Vector'
Actor = require './Actor'
Liquid = require './Liquid'

class World

  gravity: new Vector(x:0, y:0.1)
  actors: []
  borders: true

  constructor: ->
    @actors.push new Liquid
      position: new Vector(x:0, y:height-height/3)
      width: width
      height: height/3
    for i in [0..5]
      @actors.push new Actor
        mass: floor(random(10))
        position: new Vector
          x: floor(random(width))
          y: floor(random(height))

  update: ->
    for actor in @actors
      if @actors[0].contains(actor)
        actor.applyForce(@drag(actor, @actors[0]))
      actor.applyForce(@applyGravity(actor))
      actor.applyForce(@friction(actor))
      actor.update()
      if @borders then @checkBorders(actor)
      if mouseIsPressed then @mousePressed()
      actor.display()

  applyGravity: (actor)->
    gravity = @gravity.copy()
    gravity.y *= actor.mass
    return gravity

  friction: (actor)->
    c = 0.01
    N = 1
    fricMag = c * N
    friction = actor.velocity.copy()
    friction.multiply(-1)
    friction.normalize()
    friction.multiply(fricMag)
    return friction

  drag: (actor, substance)->
    mag = actor.velocity.magnitude()**2 * substance.coefficent
    dir = Vector.multiply(Vector.normalize(actor.velocity), -1)
    return dir.multiply(mag)

  checkBorders: (actor)->
    if actor.position.x > width
      actor.position.x = width
      actor.velocity.x *= -1
    else if actor.position.x < 0
      actor.position.x = 0
      actor.velocity.x *= -1
    if actor.position.y > height
      actor.position.y = height
      actor.velocity.y *= -1

  mousePressed: ->
    diff = new Vector(x:mouseX, y:-0.02)
    diff.subtract(@actors[0].position)
    diff.normalize()
    diff.multiply(0.05)
    diff.y = -0.5
    @actors[0].applyForce(diff)

module.exports = World
