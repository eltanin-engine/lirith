require "./objects"
require "./renderable"

module Lirith
  class Scene
    include Renderable

    property background_color = Math::Color.from_hex(0x7ec0ee) # 0x282828
    property children = [] of Objects::Base
  end
end
