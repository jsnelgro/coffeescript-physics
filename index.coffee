App = require './App'
window.P = P = require 'processing-js'
canvas = document.getElementById('tablurasa')

starter = (P)->

  app = new App(P)

  P.setup = ->
    app.setup()

  P.draw = ->
    app.draw()
    window.requestAnimationFrame(P.draw)

  P.mousePressed = ->
    app.mousePressed(P)

window.onmousemove = (e)->
  window.P.mouseX = e.clientX
  window.P.mouseY = e.clientY

doit = new window.Processing(canvas, starter)
window.requestAnimationFrame(doit.draw)
