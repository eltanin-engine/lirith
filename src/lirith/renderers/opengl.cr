require "./base"
require "./opengl/*"

module Lirith
  module Renderers
    class OpenGL < Base
      def initialize
        @program = Program.new
        @program.attach Shader.from_file(LibGL::E_VERTEX_SHADER, "basic.vs.glsl")
        @program.attach Shader.from_file(LibGL::E_FRAGMENT_SHADER, "basic.fs.glsl")
        @program.link

        LibGL.enable LibGL::E_DEPTH_TEST
        LibGL.depth_func LibGL::E_LESS
        # Call shader delete after linking
      end

      def render(scene : Scene, camera : Camera)
        # Check if it's the correct order.
        # It used to be;
        # Set scene color
        # Clear LibGL bits
        # Use program
        # Set uniform
        LibGL.clear LibGL::E_COLOR_BUFFER_BIT | LibGL::E_DEPTH_BUFFER_BIT

        @program.use


        @program.set_uniform_matrix_4f "view", 0_u8, camera.view.inverse
        @program.set_uniform_matrix_4f "projection", 0_u8, camera.projection

        render(scene)
      end

      def render(object : Object)
        case object
        when Scene        ; Elements::Scene.render(object)
        when Objects::Mesh
          @program.set_uniform_matrix_4f "world", 0_u8, object.view
          Elements::Mesh.render(object)
        end

        object.children.each { |child| render(child) } if object.responds_to?(:children)

        if error = LibGL.get_error
          return nil if error == LibGL::E_NO_ERROR
          puts "GL error at: 0x#{error.to_s(16)}"
        end
      end
    end
  end
end
