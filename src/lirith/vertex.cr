module Lirith
  class Vertex
    property position : Math::Vector3
    property uv = Math::Vector2.zero

    def initialize(@position : Math::Vector3)
    end

    def initialize(@position : Math::Vector3)
    end

    def initialize(@position : Math::Vector3, @uv : Math::Vector2)
    end

    def initialize(@position : Math::Vector3, @uv : Math::Vector2)
    end

    def clone
      Vertex.new(@position.clone, @uv.clone)
    end
  end
end
