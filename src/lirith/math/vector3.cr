module Lirith
  module Math
    struct TVector3(T) < TBase(T)
      @buffer : T*

      buffer_property :x, 0
      buffer_property :y, 1
      buffer_property :z, 2

      def initialize(x, y, z)
        @buffer = Pointer(T).malloc(3)
        self.x = x
        self.y = y
        self.z = z
      end

      def [](i : Int32)
        @buffer[i]
      end

      def []=(i : Int32, value)
        @buffer[i] = value
      end

      def +(v : TVector3(T))
        TVector3(T).new(x + v.x, y + v.y, z + v.z)
      end

      def -(v : TVector3(T))
        TVector3(T).new(x - v.x, y - v.y, z - v.z)
      end

      def *(a)
        Vector3(T).new(x * a, y * a, z * a)
      end

      def /(a)
        Vector3(T).new(x / a, y / a, z / a)
      end

      def length
        Math.sqrt(x * x + y * y + z * z)
      end

      def normalize
        self / length
      end

      def cross(v : TVector3(T))
        TVector3(T).new(
          y * v.z - v.y * z,
          z * v.x - v.z * x,
          x * v.y - v.x * y
        )
      end

      def dot(v : Vector3(T))
        x * v.x + y * v.y + z * v.z
      end

      def self.zero
        new T.zero, T.zero, T.zero
      end


    end
  end
end
