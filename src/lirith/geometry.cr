module Lirith
  struct Geometry
    property vertices = [] of Math::Vector3
    property vertex_colors = [] of Math::Vector3

    def initialize(@vertices)
    end
  end
end
