module Lirith
  module Core
    module Renderers
      class OpenGL
        class Program
          getter :program_id

          def initialize
            @program_id = LibGL.create_program
          end

          def attach(shader)
            shader.compile
            LibGL.attach_shader @program_id, shader.id
          end

          def link
            LibGL.link_program @program_id

            LibGL.get_programiv @program_id, LibGL::E_LINK_STATUS, out result

            if result == 0
              LibGL.get_programiv @program_id, LibGL::E_INFO_LOG_LENGTH, out info_log_length

              info_log = String.new(info_log_length) do |buffer|
                LibGL.get_program_info_log @program_id, info_log_length, nil, buffer
                {info_log_length, info_log_length}
              end

              raise "Error linking program: #{info_log}"
            end
          end

          def use
            LibGL.use_program @program_id
          end

          def set_uniform_matrix_4f(name, transpose, data)
            location = LibGL.get_uniform_location @program_id, name
            LibGL.uniform_matrix4fv location, 1, transpose, data
          end
        end
      end
    end
  end
end
