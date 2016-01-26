App = require('./App')
app = new App()

window.setup = ->
  app.setup()

window.draw = ->
  app.draw()

window.mousePressed = ->
  app.mousePressed()
