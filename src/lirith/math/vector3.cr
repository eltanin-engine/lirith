require "./base"

module Lirith
  module Math
    struct Vector3 < Base
      buffer Float32, [x, y, z]

      def initialize(x, y, z)
        self.x = x
        self.y = y
        self.z = z
      end

      # def set(x, y, z)
      #  self.x = Float32.new(x)
      #  self.y = Float32.new(y)
      #  self.z = Float32.new(z)
      # end

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
        ::Math.sqrt(x * x + y * y + z * z)
      end

      def normalize
        self / length
      end

      def apply(q : Quaternion)
        ix = q.w * x + q.y * z - q.z * y;
        iy = q.w * y + q.z * x - q.x * z;
        iz = q.w * z + q.x * y - q.y * x;
        iw = - q.x * x - q.y * y - q.z * z;

        self.x = ix * q.w + iw * - q.x + iy * - q.z - iz * - q.y;
        self.y = iy * q.w + iw * - q.y + iz * - q.x - ix * - q.z;
        self.z = iz * q.w + iw * - q.z + ix * - q.y - iy * - q.x;
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

      simple_initialize(zero, 0f32, 0f32, 0f32)

      simple_initialize(up, 0f32, 1f32, 0f32)
      simple_initialize(down, 0f32, -1f32, 0f32)

      simple_initialize(x_axis, 1f32, 0f32, 0f32)
      simple_initialize(y_axis, 0f32, 1f32, 0f32)
      simple_initialize(z_axis, 0f32, 0f32, 1f32)

    end
  end
end
