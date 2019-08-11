module Lirith
  module Materials
    class Base
      property color = Math::Color.black

      def clone
        material = Base.new
        material.color = color.clone
        material
      end
    end
  end
end
