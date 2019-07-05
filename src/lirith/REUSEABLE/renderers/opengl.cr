require "opengl"
module Lirith
  module Renderers
    class OpenGL < BaseRenderer

      getter program_id

      def initialize(settings = {} of Symbol => String|Int32|Float32, &block)
        create_window

        LibGL.gen_vertex_arrays 1, out vertex_array_id

        LibGL.gen_buffers 1, out vertex_buffer
        LibGL.gen_buffers 1, out color_buffer

        shaders = load_shaders
        @program_id = LibGL.create_program
        raise "Unable to initialize OpenGL" if @program_id == 0

        attach(shaders.first)
        attach(shaders.last)
        link
        shaders.each(&.delete)

        yield(vertex_array_id, vertex_buffer, color_buffer)
      end

      def create_window
        @window = Windows::GLFW.new(width, height, title)
      end

      def attach(shaders : Array(::OpenGL::Shader))
        shaders.each { |shader| attach(shader) }
      end

      def attach(shader)
        LibGL.attach_shader @program_id, shader.shader_id
        #p LibGL.get_error.to_s(16)
      end

      def load_shaders
        vertex_shader_code = File.read("src/lirith/shaders/vertex_shader.glsl")
        fragment_shader_code = File.read("src/lirith/shaders/fragment_shader.glsl")

        [
          ::OpenGL::Shader.vertex(vertex_shader_code).compile,
          ::OpenGL::Shader.fragment(fragment_shader_code).compile
        ]
      end

      def link
        LibGL.link_program @program_id

        LibGL.get_programiv @program_id, LibGL::E_LINK_STATUS, out result
        LibGL.get_programiv @program_id, LibGL::E_INFO_LOG_LENGTH, out info_log_length
        info_log = String.new(info_log_length) do |buffer|
          LibGL.get_program_info_log @program_id, info_log_length, nil, buffer
          {info_log_length, info_log_length}
        end
        raise "Error linking shader program: #{info_log}" unless result
        
      end

      def render(mvp)
        LibGL.use_program @program_id
        
        ::OpenGL.debug do
          LibGL.get_programiv @program_id, LibGL::E_LINK_STATUS, out linked
        end

        location = LibGL.get_uniform_location @program_id, "MVP"
        LibGL.uniform_matrix4fv location, 1, 0_u8, mvp
      end
    end
  end
end
