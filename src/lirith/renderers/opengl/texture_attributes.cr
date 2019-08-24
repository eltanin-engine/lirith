module Lirith
  module Renderers
    module OpenGL
      class TextureAttributes < Renderer::Attributes
        getter texture_id

        def initialize
          LibGL.gen_textures 1, out @texture_id
        end

        def finalize
          LibGL.delete_textures 1, pointerof(@texture_id)
        end

        def use
          LibGL.bind_texture LibGL::E_TEXTURE_2D, @texture_id
        end

        def close
          LibGL.bind_texture LibGL::E_TEXTURE_2D, 0_u32
        end
      end
    end
  end
end
