module Lirith
  module Math
    struct Color < Base
      property red : Float32
      property green : Float32
      property blue : Float32
      property alpha : Float32

      def initialize(@red, @green, @blue, @alpha = Float32.new(1))
      end

      def self.from_hex(hex : Int32)
        hex = hex.floor

        new(
          Float32.new(hex >> 16 & 255) / 255,
          Float32.new(hex >> 8 & 255) / 255,
          Float32.new(hex >> 0 & 255) / 255
        )
      end
    end
  end
end
