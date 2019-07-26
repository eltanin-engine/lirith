require "../renderer"

module Lirith
  module Objects
    abstract class Base
      include Renderer::Renderable

      property position = Math::Vector3.zero
      property quaternation = "need to implement"
      property scale = Math::Vector3.zero

      property children = [] of self

      # property render_attributes : Renderer::Attributes?
    end
  end
end
