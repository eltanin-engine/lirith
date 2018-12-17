module Lirith
  module Math
    struct TQuaternion(T) < TBase(T)
      @buffer : T*
      
      buffer_property :x, 0
      buffer_property :y, 1
      buffer_property :z, 2
      buffer_property :w, 3

      def initialize(x, y, z, w)
        @buffer = Pointer(T).malloc(4)
        set(x, y, z, w)
      end

      def set(x, y, z, w)
        self.x = x
        self.y = y
        self.z = z
        self.w = w
      end

      def set(quaternion : self.class)
        set(quaternion.x, quaternion.y, quaternion.z, quaternion.w)
      end

      def [](i : Int32)
        @buffer[i]
      end

      def []=(i : Int32, value)
        @buffer[i] = value
      end

      def length_sq
        x * x + y * y + z * z + w * w
      end

      def length_sq
        ::Math.sqrt(length_sq)
      end

    end
  end
end
