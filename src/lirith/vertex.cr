module Lirith
  class Vertex
    property position : Math::Vector3
    property uv = Math::Vector2.zero
    property color : Math::Color?

    def initialize(@position : Math::Vector3)
    end

    def initialize(@position : Math::Vector3, @color : Math::Color)
    end

    def initialize(@position : Math::Vector3, @uv : Math::Vector2)
    end

    def initialize(@position : Math::Vector3, @uv : Math::Vector2, @color : Math::Color?)
    end

    def clone
      Vertex.new(@position.clone, @uv.clone, @color.clone)
    end
  end
end
