module Lirith
  module Renderers
    class OpenGL
      class Shader
        getter :id
        getter :type

        def initialize(@type : UInt32, source)
          @id = LibGL.create_shader(@type)

          # https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/glShaderSource.xhtml
          source_ptr = source.to_unsafe
          LibGL.shader_source @id, 1, pointerof(source_ptr), nil
        end

        def compile
          LibGL.compile_shader @id

          LibGL.get_shaderiv @id, LibGL::E_COMPILE_STATUS, out result

          if result == 0
            LibGL.get_shaderiv @id, LibGL::E_INFO_LOG_LENGTH, out info_log_length

            info_log = String.new(info_log_length) do |buffer|
              LibGL.get_shader_info_log @id, info_log_length, nil, buffer
              {info_log_length, info_log_length}
            end

            raise "Error compiling shader: #{info_log}"
          end
        end

        def destroy
          LibGL.delete_shader @id
        end

        def self.from_file(type, file_path)
          search_paths = [
            file_path,
            __DIR__ + file_path,
            __DIR__ + "/shaders/" + file_path,
          ]

          search_paths.each do |path|
            if File.exists? path
              source = File.read(path)
              return new type, source
            end
          end

          raise "Unable to load shader file '#{file_path}'"
        end
      end
    end
  end
end
