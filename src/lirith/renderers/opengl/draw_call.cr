module Lirith
  module Renderers
    module OpenGL
      class DrawCall
        property uniforms = {} of String => Math::Matrix4 | UInt8
      end
    end
  end
end
