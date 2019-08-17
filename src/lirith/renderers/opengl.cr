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
        #texture_id = uninitialized UInt32

        case object
        when Scene; Elements::Scene.render(object)
        when Objects::Mesh
          @program.set_uniform_matrix_4f "world", 0_u8, object.view

          if texture = object.texture
            @program.set_uniform_bool "use_texture", 1_u8
            LibGL.gen_textures 1, out texture_id
            # Lol, this is bad
            LibGL.bind_texture(LibGL::E_TEXTURE_2D, texture_id)
            LibGL.tex_image2d(LibGL::E_TEXTURE_2D, 0, LibGL::E_RGB, texture.image.not_nil!.width, texture.image.not_nil!.height, 0, LibGL::E_BGR, LibGL::E_UNSIGNED_BYTE, texture.image.not_nil!.data)
            LibGL.tex_parameteri(LibGL::E_TEXTURE_2D, LibGL::E_TEXTURE_MAG_FILTER, LibGL::E_NEAREST)
            LibGL.tex_parameteri(LibGL::E_TEXTURE_2D, LibGL::E_TEXTURE_MIN_FILTER, LibGL::E_NEAREST)
          else
            @program.set_uniform_bool "use_texture", 0_u8
          end

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
