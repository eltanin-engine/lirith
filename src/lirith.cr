#require "lib_glew"
#require "glfw"
require "./lirith/*"
#require "lib_glfw"
#require "lib_glew"

module Lirith
  # TODO Put your code here
end
begin

end

renderer = Lirith::Renderers::OpenGL.new( {width: 1024, height: 768, title: "Crystal OpenGL"} ) do |vertex_array_id, vertex_buffer, color_buffer|

  cube = Lirith::Cube.new

  LibGL.bind_vertex_array vertex_array_id

  # Bind and set the VBO (vertex buffer object) data
  LibGL.bind_buffer LibGL::E_ARRAY_BUFFER, vertex_buffer
  LibGL.buffer_data(
    LibGL::E_ARRAY_BUFFER,
    cube.vertices.size * sizeof(Float32),
    cube.vertices.to_unsafe.as(Pointer(Void)),
    LibGL::E_STATIC_DRAW
  )

  LibGL.bind_buffer( LibGL::E_ARRAY_BUFFER, color_buffer)
  LibGL.buffer_data(
    LibGL::E_ARRAY_BUFFER,
    cube.colors.size * sizeof(Float32),
    cube.colors.to_unsafe.as(Pointer(Void)),
    LibGL::E_STATIC_DRAW
  )

  # Enable and configure the attribute 0 for each vertex position
  LibGL.enable_vertex_attrib_array 0_u32
  LibGL.bind_buffer LibGL::E_ARRAY_BUFFER, vertex_buffer
  LibGL.vertex_attrib_pointer 0_u32, 3, LibGL::E_FLOAT, 0_u8, 0, nil

  LibGL.enable_vertex_attrib_array 1_u32
  LibGL.bind_buffer LibGL::E_ARRAY_BUFFER, color_buffer
  LibGL.vertex_attrib_pointer 1_u32, 3, LibGL::E_FLOAT, 0_u8, 0, nil

  LibGL.enable LibGL::E_DEPTH_TEST
  LibGL.depth_func LibGL::E_LESS
end

#clock = Lirith::Clock.new
#camera = Lirith::Camera.new
#controls = Lirith::Controls::Fly.new(camera)
#scene = Lirith::Scene.new


mvp = Lirith::Math::Matrix4.zero
mvp_a = [1.81066,
         0,
         0.00159574,
         0.00159255,
         0,
         2.41421,
         0,
         0,
         0.00288356,
         0,
         -1.002,
         -0.999999,
         -0.0144178,
         0,
         4.8098,
         4.99999]

mvp_a.each_with_index { |e, i| mvp[i] = e.to_f32 }
#@program.set_uniform_matrix_4f "MVP", 0_u8, mvp

#p mvp[15]

renderer.window.loop do
  #delta = clock.delta

  LibGL.clear_color 0.to_f,0.5.to_f,1.to_f,0.to_f
  LibGL.clear LibGL::E_COLOR_BUFFER_BIT | LibGL::E_DEPTH_BUFFER_BIT


  renderer.render(mvp)


  LibGL.draw_arrays LibGL::E_TRIANGLES, 0, 12*3

end


#LibGL.disable_vertex_attrib_array 0_u32
#LibGL.disable_vertex_attrib_array 1_u32



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
