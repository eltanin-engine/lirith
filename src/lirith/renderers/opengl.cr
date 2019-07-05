#require "./opengl/*"

module Lirith
  module Renderers
    class OpenGL < Base
        def initialize
        end

        def render(scene : Scene)
            LibGL.clear_color scene.background[0], scene.background[1], scene.background[2], scene.background[3]
            LibGL.clear LibGL::E_COLOR_BUFFER_BIT | LibGL::E_DEPTH_BUFFER_BIT


        end
    end
  end
end
