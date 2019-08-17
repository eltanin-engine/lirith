module Lirith
  class Texture
    getter image : RImage::Image?

    def initialize(image = nil)
      @image = image
    end
  end
end
