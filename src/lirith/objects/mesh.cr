require "./base"

module Lirith
  module Objects
  class Mesh < Base
    property geometry : Geometry

    def initialize(@geometry)
    end
  end
end
end
