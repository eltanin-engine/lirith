module Lirith
  module Core
    module Renderers
      class OpenGL < Base
        def initialize
          @program = Program.new
          @program.attach Shader.from_file(LibGL::E_VERTEX_SHADER, "vertex_shader.glsl")
          @program.attach Shader.from_file(LibGL::E_FRAGMENT_SHADER, "fragment_shader.glsl")
          @program.link

          # Call shader delete after linking
        end

        def render(scene : Scene)
          LibGL.clear_color scene.background[0], scene.background[1], scene.background[2], scene.background[3]
          LibGL.clear LibGL::E_COLOR_BUFFER_BIT | LibGL::E_DEPTH_BUFFER_BIT
        end
      end
    end
  end
end

require "./opengl/*"
