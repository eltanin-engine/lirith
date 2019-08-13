require "./base"

module Lirith
  module Math
    struct Vector2 < Base
      buffer Float32, [x, y]

      def initialize(x, y)
        self.x = x
        self.y = y
      end

      def [](i : Int32)
        @buffer[i]
      end

      def []=(i : Int32, value)
        @buffer[i] = Float32.new(value)
      end

      def +(v : Vector2)
        Vector2.new(x + v.x, y + v.y)
      end

      def -(v : Vector2)
        Vector2.new(x - v.x, y - v.y)
      end

      def dot(v : Vector2)
        x * v.x + y * v.y
      end

      def *(a)
        Vector2.new(x * a, y * a)
      end

      def /(a)
        Vector2.new(x / a, y / a)
      end

      def length
        ::Math.sqrt(x * x + y * y)
      end

      def normalize
        self / length
      end

      def clone
        Vector2.new(x, y)
      end

      simple_initialize(zero, 0f32, 0f32)
    end
  end
end
