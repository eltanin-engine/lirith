module Lirith
  module Renderers
    class OpenGL < Base
      class ObjectAttributes < RenderAttributes
        property buffers = {} of Symbol => BufferAttribute
        getter vertex_array_id

        def initialize
          LibGL.gen_vertex_arrays 1, out @vertex_array_id
        end

        def use
          LibGL.bind_vertex_array @vertex_array_id
          index = 0_u32
          buffers.each do |key, buffer|
            buffer.use(index)
            index += 1_u32
          end
          #LibGL.bind_vertex_array 0_u32
        end
      end
    end
  end
end
