module Lirith
  module Renderers
    module OpenGL
      module Elements
        module Material
          extend self

          def update(material)
            Elements::Texture.update(material.texture.not_nil!) unless material.texture.nil?
          end
        end
      end
    end
  end
end
