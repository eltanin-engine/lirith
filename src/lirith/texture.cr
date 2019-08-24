require "./renderable"

module Lirith
  class Texture
    include Renderable
    getter image : RImage::Image?

    def initialize(image = nil)
      @image = image
    end
  end
end
