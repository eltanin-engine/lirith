require "./base"

module Lirith
  module Math
    struct Color < Base
      buffer Float32, [red, green, blue, alpha]

      def initialize(red, green, blue, alpha = Float32.new(1))
        @buffer[0] = red
        @buffer[1] = green
        @buffer[2] = blue
        @buffer[3] = alpha
      end

      def clone
        Color.new(red, green, blue, alpha)
      end

      def self.from_hex(hex : Int32)
        hex = hex.floor

        new(
          Float32.new(hex >> 16 & 255) / 255,
          Float32.new(hex >> 8 & 255) / 255,
          Float32.new(hex >> 0 & 255) / 255
        )
      end

      def self.random
        new(Random.rand.to_f32, Random.rand.to_f32, Random.rand.to_f32)
      end

      simple_initialize(black, 0f32, 0f32, 0f32)
      simple_initialize(white, 1f32, 1f32, 1f32)
      simple_initialize(transparent, 0f32, 0f32, 0f32, 0f32)
      simple_initialize(red, 1f32, 0f32, 0f32)
    end
  end
end
