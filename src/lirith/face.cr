require "./vertex"

module Lirith
  class Face
    property a : Vertex
    property b : Vertex
    property c : Vertex

    def initialize(@a, @b, @c)
    end
  end
end
