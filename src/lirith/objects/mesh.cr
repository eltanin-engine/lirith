require "./base"

module Lirith
  module Objects
    class Mesh < Base
      property geometry : Geometry
      property vertices = [] of Vertex

      def initialize(@geometry)
      end
    end
  end
end
