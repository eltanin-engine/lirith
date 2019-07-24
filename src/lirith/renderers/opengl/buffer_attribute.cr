module Lirith
  module Renderers
    class OpenGL < Base
      class BufferAttribute
        getter buffer_id
        getter data = [] of UInt8

        def initialize
          LibGL.gen_buffers 1, out @buffer_id
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

        def use(index : UInt32)
          LibGL.bind_buffer(LibGL::E_ARRAY_BUFFER, @buffer_id)
          LibGL.buffer_data(
            LibGL::E_ARRAY_BUFFER,
            size,
            @data.to_unsafe.as(Pointer(Void)),
            LibGL::E_STATIC_DRAW
          )

          LibGL.enable_vertex_attrib_array index
          LibGL.bind_buffer LibGL::E_ARRAY_BUFFER, @buffer_id
          LibGL.vertex_attrib_pointer index, 3, LibGL::E_FLOAT, 0_u8, 0, nil
        end
      end
    end
  end
end
