module Lirith
  module Core
    module Math
      struct Vector3 < Base
        @buffer : Float32*

        buffer_property :x, 0, Float32
        buffer_property :y, 1, Float32
        buffer_property :z, 2, Float32

        def initialize(x, y, z)
          @buffer = Pointer(Float32).malloc(3)
          set(x, y, z)
        end

        def set(x, y, z)
          self.x = Float32.new(x)
          self.y = Float32.new(y)
          self.z = Float32.new(z)
        end

        def [](i : Int32)
          @buffer[i]
        end

        def []=(i : Int32, value)
          @buffer[i] = Float32.new(value)
        end

        def +(v : Vector3)
          Vector3.new(x + v.x, y + v.y, z + v.z)
        end

        def -(v : Vector3)
          Vector3.new(x - v.x, y - v.y, z - v.z)
        end

        def *(a)
          Vector3.new(x * a, y * a, z * a)
        end

        def /(a)
          Vector3.new(x / a, y / a, z / a)
        end

        def length
          Math.sqrt(x * x + y * y + z * z)
        end

        def normalize
          self / length
        end

        def cross(v : Vector3)
          Vector3.new(
            y * v.z - v.y * z,
            z * v.x - v.z * x,
            x * v.y - v.x * y
          )
        end

        def dot(v : Vector3)
          x * v.x + y * v.y + z * v.z
        end

        def self.zero
          new Float32.zero, Float32.zero, Float32.zero
        end
      end
    end
  end
end
