require "./../texture"

module Lirith
  module Materials
    abstract class Base
      include Renderable

      property color = Math::Color.black
      property texture : Texture?

      def clone
        material = self.class.new
        material.color = color.clone
        material
      end
    end
  end
end
