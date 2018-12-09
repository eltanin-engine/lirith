require "./lirith/*"

module Lirith
  # TODO Put your code here
end

window = GLFW::Window.new

camera = Lirith::Camera.new
scene = Lirith::Scene.new
renderer = OpenGL::Program.new # ???

cube = Lirith::Mesh.new


scene.add( cube )

window.set_size(1024, 768)
