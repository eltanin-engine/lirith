module Lirith
  struct Mesh < BaseObject
    property geometry : Geometry

    def initialize(@geometry)
    end
  end
end
