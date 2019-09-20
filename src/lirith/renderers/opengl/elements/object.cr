module Lirith
  module Renderers
    module OpenGL
      module Elements
        module Object
          extend self

          def update(object)
            attributes = Attributes::Object.new

            # Vertex buffer
            vertex_buffer = Attribute::Buffer.new(Attribute::Buffer::IndexType::Position)
            vertex_buffer.set(object.vertices.map(&.position))
            attributes.buffers[:vertex] = vertex_buffer

            # Color Buffer
            if object.colors.any?
              color_buffer = Attribute::Buffer.new(Attribute::Buffer::IndexType::Color)
              color_buffer.set(object.colors.compact)
              attributes.buffers[:colors] = color_buffer
            end

            # UV buffer
            uv_buffer = Attribute::Buffer.new(Attribute::Buffer::IndexType::UV)
            uv_buffer.set(object.vertices.map(&.uv))
            attributes.buffers[:uv] = uv_buffer

            object.render_attributes = attributes
            object.needs_update = false
          end
        end
      end
    end
  end
end
