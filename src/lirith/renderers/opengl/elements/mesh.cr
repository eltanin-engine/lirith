module Lirith
  module Renderers
    module OpenGL
      module Elements
        class Mesh
          def self.render(mesh : Objects::Mesh, draw_call : DrawCall)
            program = ShaderLib.find(:basic)
            program.use

            draw_call.uniforms["world"] = mesh.view

            if texture = mesh.texture
              if texture.needs_update?
                attributes = TextureAttributes.new
                texture.render_attributes = attributes
                texture.needs_update = false

                p attributes
              end

              texture.render_attributes.try(&.use)
              LibGL.tex_image2d(LibGL::E_TEXTURE_2D, 0, LibGL::E_RGB, texture.image.not_nil!.width, texture.image.not_nil!.height, 0, LibGL::E_BGR, LibGL::E_UNSIGNED_BYTE, texture.image.not_nil!.data)
              LibGL.tex_parameteri(LibGL::E_TEXTURE_2D, LibGL::E_TEXTURE_MAG_FILTER, LibGL::E_NEAREST)
              LibGL.tex_parameteri(LibGL::E_TEXTURE_2D, LibGL::E_TEXTURE_MIN_FILTER, LibGL::E_NEAREST)
              texture.render_attributes.try(&.close)

              draw_call.uniforms["use_texture"] = 1_u8
            else
              draw_call.uniforms["use_texture"] = 0_u8
            end

            draw_call.uniforms.each do |name, data|
              case data
              when Math::Matrix4; LibGL.uniform_matrix4fv(program.uniform_location(name), 1, 0_u8, data)
              when UInt8        ; LibGL.uniform1i(program.uniform_location(name), data)
              end
            end

            if mesh.needs_update?
              attributes = ObjectAttributes.new

              # Vertex buffer
              vertex_buffer = Attributes::Buffer.new(Attributes::Buffer::IndexType::Position)
              vertex_buffer.set(mesh.vertices.map(&.position))
              attributes.buffers[:vertex] = vertex_buffer

              # Color Buffer
              color_buffer = Attributes::Buffer.new(Attributes::Buffer::IndexType::Color)
              if material = mesh.material
                color_buffer.set([material.color] * mesh.vertices.size)
              else
                color_buffer.set(mesh.vertices.map(&.color).compact)
              end
              attributes.buffers[:color] = color_buffer

              # UV buffer
              uv_buffer = Attributes::Buffer.new(Attributes::Buffer::IndexType::UV)
              uv_buffer.set(mesh.vertices.map(&.uv))
              attributes.buffers[:uv] = uv_buffer

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
