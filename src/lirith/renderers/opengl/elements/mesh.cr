module Lirith
  module Renderers
    class OpenGL < Base
      module Elements
        class Mesh
          def self.render(mesh : Objects::Mesh)
            if mesh.needs_update?
              attributes = ObjectAttributes.new

              vertex_buffer = Attributes::Buffer.new(Attributes::Buffer::IndexType::Position)
              vertex_buffer.set(mesh.vertices.map(&.position))
              attributes.buffers[:vertex] = vertex_buffer

              color_buffer = Attributes::Buffer.new(Attributes::Buffer::IndexType::Color)
              color_buffer.set(mesh.vertices.map(&.color).compact)
              attributes.buffers[:color] = color_buffer

              mesh.render_attributes = attributes
              mesh.needs_update = false
            end

            mesh.render_attributes.try(&.use) # try or not_nil! ?

            LibGL.draw_arrays LibGL::E_TRIANGLES, 0, mesh.vertices.size

            mesh.render_attributes.try(&.close)
          end
        end
      end
    end
  end
end
