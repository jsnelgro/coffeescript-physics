class Vector
  x:0
  y:0

  @add: (v1, v2)->
    new Vector(x:v1.x + v2.x, y:v1.y + v2.y)

  @subtract: (v1, v2)->
    new Vector(x:v1.x - v2.x, y:v1.y - v2.y)

  @multiply: (v1, mag)->
    new Vector(x:v1.x*mag, y:v1.y*mag)

  @divide: (v1, mag)->
    new Vector(x:v1.x/mag, y:v1.y/mag)

  @magnitude: (v1)->
    return Math.sqrt(v1.x**2 + v1.y**2)

  @normalize: (v1)->
    if Vector.magnitude(v1) > 0
      return Vector.divide(v1, Vector.magnitude(v1))
    return v1

  @limit: (v1, max)->
    if Vector.magnitude(v1) > max
      return Vector.multiply(Vector.normalize(v1), max)
    return v1

  @heading: (v1)->
    return Math.atan2(v1.y, v1.x)

  @copy: (v1)->
    return new Vector(x:v1.x, y:v1.y)

  @random: (x=100,y=100)->
    _x = Math.floor(Math.random()*x)
    _y = Math.floor(Math.random()*y)
    return new Vector(x:_x, y:_y)

  constructor: ({x, y}) ->
    @x = x || 0
    @y = y || 0
    @

  add: (v2)->
    @x += v2.x
    @y += v2.y
    @

  subtract: (v2)->
    @x -= v2.x
    @y -= v2.y
    @

  multiply: (magnitude)->
    @x *= magnitude
    @y *= magnitude
    @

  divide: (magnitude)->
    @x /= magnitude
    @y /= magnitude
    @

  magnitude: ->
    return Math.sqrt(@x**2 + @y**2)

  normalize: ->
    if @magnitude() > 0 then @divide(@magnitude()); @

  limit: (max)->
    if @magnitude() > max then @normalize(); @multiply(max); @

  heading: ->
    return Math.atan2(@y, @x)

  copy: ->
    return new Vector(x:@x, y:@y)


module.exports = Vector
