#require "lib_glew"
#require "glfw"
require "./lirith/*"
#require "lib_glfw"
#require "lib_glew"

module Lirith
  # TODO Put your code here
end

renderer = Lirith::Renderers::OpenGL.new( {width: 1024, height: 768, title: "Crystal OpenGL"} )
clock = Lirith::Clock.new
camera = Lirith::Camera.new
controls = Lirith::Controls::Fly.new(camera)
euler = Lirith::Math::Euler.new(0_f32, 1_f32, 0_f32)
p euler.x
p euler.y
p euler.z

#renderer.window.loop do
#  delta = clock.delta


#  LibGL.clear_color 0.to_f,0.to_f,1.to_f,0.to_f
#  LibGL.clear LibGL::E_COLOR_BUFFER_BIT | LibGL::E_DEPTH_BUFFER_BIT
#  controls.update(delta)
#  renderer.render
#end



#class TestApp < Lirith::Contexts::GLFW
  #def initialize
  #  @renderer = Lirith::Renderers::OpenGL.new
  #  @scene = Lirith::Scene.new
  #end

#  def render
#  end
#end

#app = TestApp.new


#p app

#renderer.render do |r|
#  r.window.run
#end

#window = GLFW::Window.new
#window.run

#camera = Lirith::Camera.new
#scene = Lirith::Scene.new
#renderer = OpenGL::Program.new # ???

#cube = Lirith::Mesh.new


#scene.add( cube )

#window.set_size(1024, 768)


# var scene = new THREE.Scene();
# var camera = new THREE.PerspectiveCamera(75, window.innerWidth/window.innerHeight, 1, 10000);
# var renderer = new THREE.WebGLRenderer();
# renderer.setSize(window.innerWidth, window.innerHeight);

# document.body.appendChild(renderer.domElement);
# var geometry = new THREE.BoxGeometry(700, 700, 700, 10, 10, 10);
# var material = new THREE.MeshBasicMaterial({color: 0xfffff, wireframe: true});
# var cube = new THREE.Mesh(geometry, material);
# scene.add(cube);
# camera.position.z = 1000;

# function render() {
#   requestAnimationFrame(render);
#   cube.rotation.x += 0.01;
#   cube.rotation.y += 0.01;
#   renderer.render(scene, camera);
# };

# render();
