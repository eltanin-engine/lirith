require "./objects"
require "./renderer"

module Lirith
  class Scene
    include Renderer::Renderable

    property background_color = Math::Color.from_hex(0xffffff) # 0x282828
    property children = [] of Objects::Base
  end
end
