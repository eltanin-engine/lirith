require "./base"

module Lirith
  module Math
    struct Matrix4 < Base
      buffer Float32, [
        m00, m01, m02, m03,
        m10, m11, m12, m13,
        m20, m21, m22, m23,
        m30, m31, m32, m33,
      ]

      def [](i : Int32)
        @buffer[i]
      end

      def []=(i : Int32, value)
        @buffer[i] = Float32.new(value)
      end

      def [](row : Int32, col : Int32)
        @buffer[row + (col * 4)]
      end

      def []=(row : Int32, col : Int32, value)
        @buffer[row + (col * 4)] = Float32.new(value)
      end

      def *(matrix : Matrix4)
        new_matrix = self.class.zero

        0.upto(3) do |row|
          0.upto(3) do |col|
            p1 = @buffer + row
            p2 = matrix.to_unsafe + 4 * col
            new_matrix[row, col] = p1[0] * p2[0] + p1[4] * p2[1] + p1[8] * p2[2] + p1[12] * p2[3]
          end
        end

        new_matrix
      end

      def determinant
        m03*m12*m21*m30 - m02*m13*m21*m30 - m03*m11*m22*m30 + m01*m13*m22*m30+
        m02*m11*m23*m30 - m01*m12*m23*m30 - m03*m12*m20*m31 + m02*m13*m20*m31+
        m03*m10*m22*m31 - m00*m13*m22*m31 - m02*m10*m23*m31 + m00*m12*m23*m31+
        m03*m11*m20*m32 - m01*m13*m20*m32 - m03*m10*m21*m32 + m00*m13*m21*m32+
        m01*m10*m23*m32 - m00*m11*m23*m32 - m02*m11*m20*m33 + m01*m12*m20*m33+
        m02*m10*m21*m33 - m00*m12*m21*m33 - m01*m10*m22*m33 + m00*m11*m22*m33
      end

      def rotate(q : Quaternion)
        self.m00 = 1 - ((q.y * (q.y + q.y)) + (q.z * (q.z + q.z)))
        self.m01 = (q.x * (q.y + q.y)) + (q.w * (q.z + q.z))
        self.m02 = (q.x * (q.z + q.z)) - (q.w * (q.y + q.y))
        self.m03 = 0


        self.m10 = (q.x * (q.y + q.y)) - (q.w * (q.z + q.z))
        self.m11 = 1 - ( (q.x * (q.x + q.x)) + (q.z * (q.z + q.z)) )
        self.m12 = (q.y * (q.z + q.z)) + (q.w * (q.x + q.x))
        self.m13 = 0

        self.m20 = (q.x * (q.z + q.z)) + (q.w * (q.y + q.y))
        self.m21 = (q.y * (q.z + q.z)) - (q.w * (q.x + q.x))
        self.m22 = 1 - ( (q.x * (q.x + q.x)) + (q.y * (q.y + q.y)) )
        self.m23 = 0

        self.m30 = 0
        self.m31 = 0
        self.m32 = 0
        self.m33 = 1
      end

      def position(position : Vector3)
        self.m30 = position.x
        self.m31 = position.y
        self.m32 = position.z
      end

      def scale(scale : Vector3)
        self.m00 *= scale.x;
        self.m01 *= scale.x;
        self.m02 *= scale.x;
        self.m03 *= scale.x;

        self.m10 *= scale.y;
        self.m11 *= scale.y;
        self.m12 *= scale.y;
        self.m13 *= scale.y;

        self.m20 *= scale.z;
        self.m21 *= scale.z;
        self.m22 *= scale.z;
        self.m23 *= scale.z;
      end

      def inverse
        self.class.inverse(self)
      end

      def self.new(&block : Int32 -> Float32)
        matrix = self.new

        0.upto(15) do |i|
          matrix[i] = yield i
        end

        matrix
      end

      def self.new(matrix : Array(Float32))
        raise ArgumentError.new("Given matrix array is not the correct size") unless matrix.size == 16

        self.new { |i| matrix[i] }
      end

      def self.zero
        new { Float32.zero }
      end

      def self.identity : Matrix4
        matrix = self.zero

        matrix[0, 0] = Float32.new(1)
        matrix[1, 1] = Float32.new(1)
        matrix[2, 2] = Float32.new(1)
        matrix[3, 3] = Float32.new(1)

        matrix
      end

      def self.perspective(left, right, top, bottom, near, far) : Matrix4
        matrix = self.zero

        matrix[0] = 2 * near / (right - left)
        matrix[5] = 2 * near / (top - bottom)
        matrix[8] = (right + left) / (right - left)
        matrix[9] = (top + bottom) / (top - bottom)
        matrix[10] = -((far + near) / (far - near))
        matrix[10] = Float32.new(-1)
        matrix[14] = -2 * far * near / (far - near)

        matrix
      end

      def self.perspectiveFov(fov_y, aspect, near, far) : Matrix4
        raise ArgumentError.new("Aspect ratio can not be zero") if aspect == 0
        raise ArgumentError.new("Near and Far can not be equal") if near == far
        rad = (fov_y / 180.0 * ::Math::PI)
        tan_half_fov = Float32.new(::Math.tan(rad / 2))

        matrix = self.zero

        matrix[0, 0] = 1 / (aspect * tan_half_fov)
        matrix[1, 1] = 1 / tan_half_fov
        matrix[2, 2] = -(far + near) / (far - near)
        matrix[3, 2] = -1_f32
        matrix[2, 3] = -(2_f32 * far * near) / (far - near)

        matrix
      end

      def self.look_at(eye, center, up)
        matrix = self.identity

        z = (center - eye).normalize
        x = z.cross(up).normalize
        y = x.cross(z)

        matrix[0, 0] = x.x
        matrix[0, 1] = x.y
        matrix[0, 2] = x.z
        matrix[1, 0] = y.x
        matrix[1, 1] = y.y
        matrix[1, 2] = y.z
        matrix[2, 0] = -z.x
        matrix[2, 1] = -z.y
        matrix[2, 2] = -z.z
        matrix[0, 3] = -x.dot(eye)
        matrix[1, 3] = -y.dot(eye)
        matrix[2, 3] = z.dot(eye)

        matrix
      end

      def self.inverse(m)
        matrix = self.zero

        matrix.m00 = m.m12*m.m23*m.m31 - m.m13*m.m22*m.m31 + m.m13*m.m21*m.m32 - m.m11*m.m23*m.m32 - m.m12*m.m21*m.m33 + m.m11*m.m22*m.m33
        matrix.m01 = m.m03*m.m22*m.m31 - m.m02*m.m23*m.m31 - m.m03*m.m21*m.m32 + m.m01*m.m23*m.m32 + m.m02*m.m21*m.m33 - m.m01*m.m22*m.m33
        matrix.m02 = m.m02*m.m13*m.m31 - m.m03*m.m12*m.m31 + m.m03*m.m11*m.m32 - m.m01*m.m13*m.m32 - m.m02*m.m11*m.m33 + m.m01*m.m12*m.m33
        matrix.m03 = m.m03*m.m12*m.m21 - m.m02*m.m13*m.m21 - m.m03*m.m11*m.m22 + m.m01*m.m13*m.m22 + m.m02*m.m11*m.m23 - m.m01*m.m12*m.m23

        matrix.m10 = m.m13*m.m22*m.m30 - m.m12*m.m23*m.m30 - m.m13*m.m20*m.m32 + m.m10*m.m23*m.m32 + m.m12*m.m20*m.m33 - m.m10*m.m22*m.m33
        matrix.m11 = m.m02*m.m23*m.m30 - m.m03*m.m22*m.m30 + m.m03*m.m20*m.m32 - m.m00*m.m23*m.m32 - m.m02*m.m20*m.m33 + m.m00*m.m22*m.m33
        matrix.m12 = m.m03*m.m12*m.m30 - m.m02*m.m13*m.m30 - m.m03*m.m10*m.m32 + m.m00*m.m13*m.m32 + m.m02*m.m10*m.m33 - m.m00*m.m12*m.m33
        matrix.m13 = m.m02*m.m13*m.m20 - m.m03*m.m12*m.m20 + m.m03*m.m10*m.m22 - m.m00*m.m13*m.m22 - m.m02*m.m10*m.m23 + m.m00*m.m12*m.m23

        matrix.m20 = m.m11*m.m23*m.m30 - m.m13*m.m21*m.m30 + m.m13*m.m20*m.m31 - m.m10*m.m23*m.m31 - m.m11*m.m20*m.m33 + m.m10*m.m21*m.m33
        matrix.m21 = m.m03*m.m21*m.m30 - m.m01*m.m23*m.m30 - m.m03*m.m20*m.m31 + m.m00*m.m23*m.m31 + m.m01*m.m20*m.m33 - m.m00*m.m21*m.m33
        matrix.m22 = m.m01*m.m13*m.m30 - m.m03*m.m11*m.m30 + m.m03*m.m10*m.m31 - m.m00*m.m13*m.m31 - m.m01*m.m10*m.m33 + m.m00*m.m11*m.m33
        matrix.m23 = m.m03*m.m11*m.m20 - m.m01*m.m13*m.m20 - m.m03*m.m10*m.m21 + m.m00*m.m13*m.m21 + m.m01*m.m10*m.m23 - m.m00*m.m11*m.m23

        matrix.m30 = m.m12*m.m21*m.m30 - m.m11*m.m22*m.m30 - m.m12*m.m20*m.m31 + m.m10*m.m22*m.m31 + m.m11*m.m20*m.m32 - m.m10*m.m21*m.m32
        matrix.m31 = m.m01*m.m22*m.m30 - m.m02*m.m21*m.m30 + m.m02*m.m20*m.m31 - m.m00*m.m22*m.m31 - m.m01*m.m20*m.m32 + m.m00*m.m21*m.m32
        matrix.m32 = m.m02*m.m11*m.m30 - m.m01*m.m12*m.m30 - m.m02*m.m10*m.m31 + m.m00*m.m12*m.m31 + m.m01*m.m10*m.m32 - m.m00*m.m11*m.m32
        matrix.m33 = m.m01*m.m12*m.m20 - m.m02*m.m11*m.m20 + m.m02*m.m10*m.m21 - m.m00*m.m12*m.m21 - m.m01*m.m10*m.m22 + m.m00*m.m11*m.m22

        matrix
      end
    end
  end
end
