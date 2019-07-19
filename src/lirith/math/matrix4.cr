module Lirith
  module Math
    struct Matrix4 < Base
      buffer Float32, [
        m00, m01, m02, m03,
        m10, m11, m12, m13,
        m20, m21, m22, m23,
        m30, m31, m32, m33
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

      def to_unsafe
        @buffer
      end

      def self.new(&block : Int32 -> Float32)
        matrix = self.new

        0.upto(15) do |i|
          matrix[i] = yield i
        end

        matrix
      end

      # def self.new(&block : (Int32, Int32) -> Float32)
      #  matrix = self.new

      #  0.upto(3) do |row|
      #    0.upto(3) do |col|
      #      buffer[row + (4 * col)] = yield row, col
      #    end
      #  end

      #  matrix
      # end

      def self.new(matrix : Array(Float32))
        raise ArgumentError.new("Given matrix array is not the correct size") unless matrix.size == 16

        self.new { |i| matrix[i] }
      end

      def self.zero
        new { Float32.zero }
      end

      def self.identity : Matrix4
        matrix = self.zero

        matrix[0] = Float32.new(1)
        matrix[5] = Float32.new(1)
        matrix[10] = Float32.new(1)
        matrix[15] = Float32.new(1)

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
    end
  end
end
