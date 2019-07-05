module Lirith
    module Renderers
        class OpenGL
            class Program
                getter :program_id

                def initialize
                    @program_id = LibGL.create_program
                end

                def attach(shader)
                    LibGL.attach_shader @program_id, shader.id
                end

                def link
                    LibGL.link_program @program_id

                    LibGL.get_programiv @program_id, LibGL::E_LINK_STATUS, out result

                    unless result
                        LibGL.get_programiv @program_id, LibGL::E_INFO_LOG_LENGTH, out info_log_length

                        info_log = String.new(info_log_length) do |buffer|
                            LibGL.get_program_info_log @program_id, info_log_length, nil, buffer
                            {info_log_length, info_log_length}
                        end

                        raise "Error linking program: #{info_log}"
                    end
                end
            end
        end
    end
end