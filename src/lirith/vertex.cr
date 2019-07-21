module Lirith
  struct Vertex
    property position : Math::Vector3
    property color : Math::Color?

    def initialize(@position)
    end

    def initialize(@position, @color)
    end
  end
end
