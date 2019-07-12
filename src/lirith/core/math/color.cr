module Lirith
  module Core
    module Math
      struct Color < Base
        @buffer : Float32*

        buffer_property :red, 0, Float32
        buffer_property :green, 1, Float32
        buffer_property :blue, 2, Float32
        buffer_property :alpha, 3, Float32

        def initialize(red, green, blue, alpha = Float32.new(1))
          @buffer = Pointer(Float32).malloc(4)
          @buffer[0] = red
          @buffer[1] = green
          @buffer[2] = blue
          @buffer[3] = alpha
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
end
