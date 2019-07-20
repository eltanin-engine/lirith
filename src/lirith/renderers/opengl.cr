require "./base"
require "./opengl/*"

module Lirith
  module Renderers
    class OpenGL < Base
      def initialize
        @program = Program.new
        @program.attach Shader.from_file(LibGL::E_VERTEX_SHADER, "vertex_shader.glsl")
        @program.attach Shader.from_file(LibGL::E_FRAGMENT_SHADER, "fragment_shader.glsl")
        @program.link

        @once = false
        # Call shader delete after linking
      end

      def render(scene : Scene, camera : Camera)
        LibGL.clear_color scene.background_color.red, scene.background_color.green, scene.background_color.blue, scene.background_color.alpha
        LibGL.clear LibGL::E_COLOR_BUFFER_BIT | LibGL::E_DEPTH_BUFFER_BIT

        @program.use
        @program.set_uniform_matrix_4f "MVP", 0_u8, camera.mvp

        #unless @once
          @once = true
          scene.children.each do |scene_obj|
            if scene_obj.is_a?(Objects::Mesh)
              if scene_obj.render_attributes.nil?
                attributes = ObjectAttributes.new
                vertex_buffer = BufferAttribute.new
                vertex_buffer.set(scene_obj.geometry.vertices)
                attributes.buffers[:vertex] = vertex_buffer

                color_buffer = BufferAttribute.new
                color_buffer.set(scene_obj.geometry.vertex_colors)
                attributes.buffers[:color] = vertex_buffer

                attributes.use

                scene_obj.render_attributes = attributes
              end
            end
          #end

          LibGL.enable LibGL::E_DEPTH_TEST
          LibGL.depth_func LibGL::E_LESS
        end

        if error = LibGL.get_error
          return nil if error == LibGL::E_NO_ERROR
          puts "GL error at: 0x#{error.to_s(16)}"
        end
      end
    end
  end
end
