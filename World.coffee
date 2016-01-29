Vector = require './Vector'
Actor = require './Actor'
Liquid = require './Liquid'
Attractor = require './Attractor'

class World

  gravity: new Vector(x:0, y:0.1)
  actors: []
  borders: true

  constructor: ->
    @actors.push new Liquid
      position: new Vector(x:0, y:P.height-P.height/4)
      width: P.width
      height: P.height/4
    for i in [0...5]
      @actors.push new Actor
        mass: P.floor(P.random(3))
        position: new Vector
          x: P.floor(P.random(P.width))
          y: P.floor(P.random(P.height/2))
    @mouse = new Actor
      position: new Vector(x:P.mouseX, y:P.mouseY)
      mass: 6

  update: ->
    @mouse.position = new Vector(x:P.mouseX, y:P.mouseY)
    for actor in @actors
      if @actors[0].contains(actor)
        actor.applyForce(@drag(actor, @actors[0]))
      for actor2 in @actors
        if actor2 != actor
          actor.applyForce(actor2.repel(actor))
      actor.applyForce @mouse.calculateAttraction(actor)
      # actor.applyForce Vector.multiply new Vector(x:0,y:0.1), actor.mass
      actor.applyForce(@friction(actor))
      actor.update()
      if @borders then @checkBorders(actor)
      if P.mousePressed then @mousePressed()

  display: ->
    @mouse.display()
    for actor in @actors
      actor.display()

  applyGravity: (actor1, actor2)->
    dir = Vector.subtract(actor1.position, actor2.position)
    distance = constrain(dir.magnitude())
    dir.normalize()
    mag = (1 * actor1.mass * actor2.mass) / distance**2
    return Vector.multiply(dir, mag)

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

  checkBorders: (actor, wrap=true)->
    if wrap
      actor.position.x = actor.position.x %% P.width
      actor.position.y = actor.position.y %% P.height
    else
      if actor.position.x > P.width
        actor.position.x = P.width
        actor.velocity.x *= -1
      else if actor.position.x < 0
        actor.position.x = 0
        actor.velocity.x *= -1
      if actor.position.y > P.height
        actor.position.y = P.height
        actor.velocity.y *= -1

  mousePressed: ->
    diff = new Vector(x:P.mouseX, y:-0.02)
    diff.subtract(@actors[0].position)
    diff.normalize()
    diff.multiply(0.05)
    diff.y = -0.5
    @actors[0].applyForce(diff)

module.exports = World
