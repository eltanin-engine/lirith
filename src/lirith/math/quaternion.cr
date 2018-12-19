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
        self.x = T.new(x)
        self.y = T.new(y)
        self.z = T.new(z)
        self.w = T.new(w)
      end

      def set(quaternion : TQuaternion(T))
        set(quaternion.x, quaternion.y, quaternion.z, quaternion.w)
      end

      # Todo: make this not ugly
      def set(euler : TEuler(T))
        c1 = ::Math.cos(euler.x / 2.0)
        c2 = ::Math.cos(euler.y / 2.0)
        c3 = ::Math.cos(euler.z / 2.0)
        s1 = ::Math.sin(euler.x / 2.0)
        s2 = ::Math.sin(euler.y / 2.0)
        s3 = ::Math.sin(euler.z / 2.0)

        case euler.order
        when "XYZ"
          self.x = s1 * c2 * c3 + c1 * s2 * s3
          self.y = c1 * s2 * c3 - s1 * c2 * s3
          self.z = c1 * c2 * s3 + s1 * s2 * c3
          self.w = c1 * c2 * c3 - s1 * s2 * s3
        when "YXZ"
          self.x = s1 * c2 * c3 + c1 * s2 * s3
          self.y = c1 * s2 * c3 - s1 * c2 * s3
          self.z = c1 * c2 * s3 - s1 * s2 * c3
          self.w = c1 * c2 * c3 + s1 * s2 * s3
        when "ZXY"
          self.x = s1 * c2 * c3 - c1 * s2 * s3
          self.y = c1 * s2 * c3 + s1 * c2 * s3
          self.z = c1 * c2 * s3 + s1 * s2 * c3
          self.w = c1 * c2 * c3 - s1 * s2 * s3
        when "ZYX"
          self.x = s1 * c2 * c3 - c1 * s2 * s3
          self.y = c1 * s2 * c3 + s1 * c2 * s3
          self.z = c1 * c2 * s3 - s1 * s2 * c3
          self.w = c1 * c2 * c3 + s1 * s2 * s3
        when "YZX"
          self.x = s1 * c2 * c3 + c1 * s2 * s3
          self.y = c1 * s2 * c3 + s1 * c2 * s3
          self.z = c1 * c2 * s3 - s1 * s2 * c3
          self.w = c1 * c2 * c3 - s1 * s2 * s3
        when "XZY"
          self.x = s1 * c2 * c3 - c1 * s2 * s3
          self.y = c1 * s2 * c3 - s1 * c2 * s3
          self.z = c1 * c2 * s3 + s1 * s2 * c3
          self.w = c1 * c2 * c3 + s1 * s2 * s3
        end

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

      # https://github.com/mrdoob/three.js/blob/master/src/math/Quaternion.js#L404
      def slerp(quaternion : TQuaternion(T), t : Float)
        return self if t == 0.0
        return set(quaternion) if t == 1.0
        x_cache, y_cache, z_cache, w_cache = x, y, z, w

        cos_half_theta = w_cache * quaternion.w + x_cache * quaternion.x + y_cache * quaternion.y + z_cache * quaternion.z
        if cos_half_theta < 0.0
          set( -quaternion.x, -quaternion.y, -quaternion.z, -quaternion.w )
          cos_half_theta = -cos_half_theta
        else
          set(quaternion)
        end
        if cos_half_theta >= 1.0
          set(x_cache, y_cache, z_cache, w_cache)
          return self
        end

        sin_half_theta = ::Math.sqrt(1.0 - cos_half_theta * cos_half_theta)
        if sin_half_theta.abs < 0.001
          set(
            T.new(0.5 * (x_cache + x)),
            T.new(0.5 * (y_cache + y)),
            T.new(0.5 * (z_cache + z)),
            T.new(0.5 * (w_cache + w))
          )
          return self
        end

        half_theta = ::Math.atan2(sin_half_theta, cos_half_theta)
        ratio_a = ::Math.sin((1 - t) * half_theta) / sin_half_theta
        ratio_b = ::Math.sin(t * half_theta) / sin_half_theta

        set(
          T.new(x_cache * ratio_a + x * ratio_b),
          T.new(y_cache * ratio_a + y * ratio_b),
          T.new(z_cache * ratio_a + z * ratio_b),
          T.new(w_cache * ratio_a + w * ratio_b)
        )
        self
      end

      def self.zero
        new T.zero, T.zero, T.zero, T.zero
      end

    end
  end
end
