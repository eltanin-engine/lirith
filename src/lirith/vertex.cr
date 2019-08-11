module Lirith
  class Vertex
    property position : Math::Vector3
    property color : Math::Color?

    def initialize(@position)
    end

    def initialize(@position, @color)
    end

    def clone
      Vertex.new(@position.clone, @color.clone)
    end
  end
end
