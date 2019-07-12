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

          @mvp = Math::Matrix4.new([
            Float32.new(1.8106579), Float32.new(0.0), Float32.new(0.0015957365), Float32.new(0.0015925482),
            Float32.new(0.0), Float32.new(2.4142134), Float32.new(0), Float32.new(0),
            Float32.new(0.0028835635), Float32.new(0), Float32.new(-1.0020007), Float32.new(-0.99999875),
            Float32.new(-0.014417818), Float32.new(0), Float32.new(4.8098035), Float32.new(4.999994),
          ])
        end

        def render(scene : Scene, camera : Camera)
          LibGL.clear_color scene.background_color.red, scene.background_color.green, scene.background_color.blue, scene.background_color.alpha
          LibGL.clear LibGL::E_COLOR_BUFFER_BIT | LibGL::E_DEPTH_BUFFER_BIT

          @program.use
          @program.set_uniform_matrix_4f "MVP", 0_u8, camera.mvp

          if error = LibGL.get_error
            return nil if error == LibGL::E_NO_ERROR
            puts "GL error at: 0x#{error.to_s(16)}"
          end
        end
      end
    end
  end
end

require "./opengl/*"
