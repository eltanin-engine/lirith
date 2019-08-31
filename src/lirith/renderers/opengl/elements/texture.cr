module Lirith
  module Renderers
    module OpenGL
      module Elements
        module Texture
          extend self

          def update(texture)
            return unless texture.needs_update?

            attributes = Attributes::Texture.new
            texture.render_attributes = attributes
            texture.needs_update = false
          end

          def use(texture)
            LibGL.tex_image2d(LibGL::E_TEXTURE_2D, 0, LibGL::E_RGB, texture.image.not_nil!.width, texture.image.not_nil!.height, 0, LibGL::E_BGR, LibGL::E_UNSIGNED_BYTE, texture.image.not_nil!.data)
            LibGL.tex_parameteri(LibGL::E_TEXTURE_2D, LibGL::E_TEXTURE_MAG_FILTER, LibGL::E_NEAREST)
            LibGL.tex_parameteri(LibGL::E_TEXTURE_2D, LibGL::E_TEXTURE_MIN_FILTER, LibGL::E_NEAREST)
          end
        end
      end
    end
  end
end
