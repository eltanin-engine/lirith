require "../renderer"

module Lirith
  module Objects
    abstract class Base
      include Drawable

      property children = [] of self

      # property render_attributes : Renderer::Attributes?
    end
  end
end
