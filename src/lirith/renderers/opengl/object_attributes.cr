module Lirith
  module Renderers
    class OpenGL < Base
      class ObjectAttributes < Renderer::Attributes
        property buffers = {} of Symbol => Attributes::Buffer
        getter vertex_array_id

        def initialize
          LibGL.gen_vertex_arrays 1, out @vertex_array_id
        end

        def finalize
          LibGL.delete_vertex_arrays 1, pointerof(@vertex_array_id)
        end

        def use
          LibGL.bind_vertex_array @vertex_array_id
          buffers.values.each(&.use)
        end

        def close
          buffers.values.each(&.close)
          LibGL.bind_vertex_array 0_u32
        end
      end
    end
  end
end
