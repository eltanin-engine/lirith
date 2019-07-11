module Lirith
  module Application
    module Systems
      class Scene < Core::Systems::Base
        def initialize
          @model = Models::Cube.new

          LibGL.gen_vertex_arrays 1, out @vertex_array_id

          LibGL.gen_buffers 1, out @vertex_buffer
          LibGL.gen_buffers 1, out @color_buffer
        end

        def load_model
          # Bind the VAO (vertex array object)
          LibGL.bind_vertex_array @vertex_array_id

          # Bind and set the VBO (vertex buffer object) data
          LibGL.bind_buffer LibGL::E_ARRAY_BUFFER, @vertex_buffer
          LibGL.buffer_data(
            LibGL::E_ARRAY_BUFFER,
            @model.vertices.size * sizeof(Float32),
            @model.vertices.to_unsafe.as(Pointer(Void)),
            LibGL::E_STATIC_DRAW
          )

          LibGL.bind_buffer(LibGL::E_ARRAY_BUFFER, @color_buffer)
          LibGL.buffer_data(
            LibGL::E_ARRAY_BUFFER,
            @model.colors.size * sizeof(Float32),
            @model.colors.to_unsafe.as(Pointer(Void)),
            LibGL::E_STATIC_DRAW
          )

          # Enable and configure the attribute 0 for each vertex position
          LibGL.enable_vertex_attrib_array 0_u32
          LibGL.bind_buffer LibGL::E_ARRAY_BUFFER, @vertex_buffer
          LibGL.vertex_attrib_pointer 0_u32, 3, LibGL::E_FLOAT, 0_u8, 0, nil

          LibGL.enable_vertex_attrib_array 1_u32
          LibGL.bind_buffer LibGL::E_ARRAY_BUFFER, @color_buffer
          LibGL.vertex_attrib_pointer 1_u32, 3, LibGL::E_FLOAT, 0_u8, 0, nil

          LibGL.enable LibGL::E_DEPTH_TEST
          LibGL.depth_func LibGL::E_LESS
        end

        def handle_event(event, payload)
          case event
          when Render::Event::Start; load_model
          end
        end
      end
    end
  end
end
