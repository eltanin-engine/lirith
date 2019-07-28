module Lirith
  module Renderers
    class OpenGL < Base
      module Attributes
        class Buffer
          enum IndexType
            # MUST be the same as defined in the vertex shader
            Position = 0
            Color = 1
          end

          getter buffer_id
          getter data = [] of UInt8
          getter index_type : IndexType
          getter? build = false

          def initialize(@index_type)
            LibGL.gen_buffers 1, out @buffer_id
          end

          def finalize
            LibGL.delete_buffers 1, pointerof(@buffer_id)
          end

          def set(vertices : Array(Math::Base))
            vertices.each do |v|
              v.to_slice.each do |byte|
                @data << byte
              end
            end
          end

          def size
            @data.size * sizeof(UInt8)
          end

          def use
            LibGL.bind_buffer(LibGL::E_ARRAY_BUFFER, @buffer_id)

            build!
          end

          def close
            LibGL.disable_vertex_attrib_array 0
          end

          def build!
            return if build?

            LibGL.buffer_data(
              LibGL::E_ARRAY_BUFFER,
              size,
              @data.to_unsafe.as(Pointer(Void)),
              LibGL::E_STATIC_DRAW
            )

            LibGL.enable_vertex_attrib_array @index_type.value
            LibGL.bind_buffer LibGL::E_ARRAY_BUFFER, @buffer_id
            LibGL.vertex_attrib_pointer @index_type.value, 3, LibGL::E_FLOAT, 0_u8, 0, nil

            build = true
          end
        end
      end
    end
  end
end
