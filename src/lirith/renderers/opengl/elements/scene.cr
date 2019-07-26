module Lirith
  module Renderers
    class OpenGL < Base
      module Elements
        class Scene
          def self.render(scene : Lirith::Scene)
            return unless scene.needs_update?

            LibGL.clear_color scene.background_color.red, scene.background_color.green, scene.background_color.blue, scene.background_color.alpha
          end
        end
      end
    end
  end
end
