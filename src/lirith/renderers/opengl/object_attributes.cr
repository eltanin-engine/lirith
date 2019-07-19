module Lirith
  module Renderers
    class OpenGL < Base
      class ObjectAttributes
        property buffers = {} of Symbol => BufferAttribute
        getter vertex_array_id

        def initialize
          LibGL.gen_vertex_arrays 1, out @vertex_array_id

          #LibGL.bind_vertex_array @vertex_array_id
          # Do something
          #LibGL.bind_vertex_array 0
        end

        def use
          LibGL.bind_vertex_array @vertex_array_id
          index = 0_u32
          buffers.each do |key, buffer|
            buffer.use(index)
            index += 1_u32
          end
        end
      end
    end
  end
end
