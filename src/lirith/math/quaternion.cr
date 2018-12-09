module Lirith
  module Math
    struct TQuaternion(T)
      @buffer : T*

      def initialize(x, y, z, w)
        @buffer = Pointer(T).malloc(4)
        @buffer[0] = x
        @buffer[1] = y
        @buffer[2] = z
        @buffer[3] = w
      end

      def [](i : Int32)
        @buffer[i]
      end

      def []=(i : Int32, value)
        @buffer[i] = value
      end

      def x
        @buffer[0]
      end

      def x=(value)
        @buffer[0] = value
      end

      def y
        @buffer[1]
      end

      def y=(value)
        @buffer[1] = value
      end

      def z
        @buffer[2]
      end

      def z=(value)
        @buffer[2] = value
      end

      def w
        @buffer[2]
      end

      def w=(value)
        @buffer[3] = value
      end

    end
  end
end
