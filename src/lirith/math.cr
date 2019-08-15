require "./math/*"

module Lirith
  module Math
    extend self

    def deg2rad(angle : Float)
      angle * {{::Math::PI / 180}}
    end

    def rad2deg(angle : Float)
      angle * {{180 / ::Math::PI}}
    end
  end
end
