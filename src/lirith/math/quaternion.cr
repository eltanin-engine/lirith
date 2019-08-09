require "./base"

module Lirith
  module Math
    struct Quaternion < Base
      buffer Float32, [w, x, y, z]

      def initialize(x, y, z, w = 1_f32)
        self.x = x
        self.y = y
        self.z = z
        self.w = w
      end

      def setFromRotation(matrix : Matrix4)
        trace = matrix[0, 0] + matrix[1, 1] + matrix[2, 2]

        if(trace > 0)
          num = 0.5 / ::Math.sqrt( trace + 1.0 )

          self.w = 0.25 / num;
          self.x = ( matrix[2, 1] - matrix[1, 2] ) * num;
          self.y = ( matrix[0, 2] - matrix[2, 0] ) * num;
          self.z = ( matrix[1, 0] - matrix[0, 1] ) * num;
        elsif(matrix[0, 0] > matrix[1, 1] && matrix[0, 0] > matrix[2, 2])
          num = 2.0 * ::Math.sqrt(1.0 + matrix[0, 0] - matrix[1, 1] - matrix[2, 2]);

          self.w = ( matrix[2, 1] - matrix[1, 2] ) / num;
          self.x = 0.25 * num;
          self.y = ( matrix[0, 1] + matrix[1, 0] ) / num;
          self.z = ( matrix[0, 2] + matrix[2, 0] ) / num;
        elsif(matrix[1, 1] > matrix[2, 2])
          num = 2.0 * ::Math.sqrt( 1.0 + matrix[1, 1] - matrix[0, 0] - matrix[2, 2] );

          self.w = ( matrix[0, 2] - matrix[2, 0] ) / num;
          self.x = ( matrix[0, 1] + matrix[1, 0] ) / num;
          self.y = 0.25 * num;
          self.z = ( matrix[1, 2] + matrix[2, 1] ) / num;
        else
          num = 2.0 * ::Math.sqrt( 1.0 + matrix[2, 2] - matrix[0, 0] - matrix[1, 1] );

          self.w = ( matrix[1, 0] - matrix[0, 1] ) / num;
          self.x = ( matrix[0, 2] + matrix[2, 0] ) / num;
          self.y = ( matrix[1, 2] + matrix[2, 1] ) / num;
          self.z = 0.25 * num;
        end

        p self
      end

    end
  end
end
