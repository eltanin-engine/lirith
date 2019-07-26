module Lirith
  module Renderers
    class OpenGL < Base
      module Elements
        class Mesh
          def self.render(mesh : Objects::Mesh)
            if mesh.needs_update?
              attributes = ObjectAttributes.new

              vertex_buffer = Attributes::Buffer.new
              vertex_buffer.set(mesh.vertices.map(&.position))
              attributes.buffers[:vertex] = vertex_buffer

              color_buffer = Attributes::Buffer.new
              color_buffer.set(mesh.vertices.map(&.color).compact)
              attributes.buffers[:color] = vertex_buffer

              attributes.use

              mesh.render_attributes = attributes
              mesh.needs_update = false
            end

            LibGL.draw_arrays LibGL::E_TRIANGLES, 0, mesh.vertices.size
          end
        end
      end
    end
  end
end
