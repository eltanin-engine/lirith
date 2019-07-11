1.8106579
0.0
0.0015957365
0.0015925482
0.0
2.4142134
0.0
0.0
0.0028835635
0.0
-1.0020007
-0.99999875
-0.014417818
0.0
4.8098035
4.999994

module Lirith
  module Core
    module Math
      struct Matrix4 < Base
        @buffer : Float32*

        def initialize
          @buffer = Pointer(Float32).malloc(16)

          @buffer[0] = Float32.new 1.8106579
          @buffer[1] = Float32.new 0.0
          @buffer[2] = Float32.new 0.0015957365
          @buffer[3] = Float32.new 0.0015925482
          @buffer[4] = Float32.new 0.0
          @buffer[5] = Float32.new 2.4142134
          @buffer[6] = Float32.new 0.0
          @buffer[7] = Float32.new 0.0
          @buffer[8] = Float32.new 0.0028835635
          @buffer[9] = Float32.new 0.0
          @buffer[10] = Float32.new -1.0020007
          @buffer[11] = Float32.new -0.99999875
          @buffer[12] = Float32.new -0.014417818
          @buffer[13] = Float32.new 0.0
          @buffer[14] = Float32.new 4.8098035
          @buffer[15] = Float32.new 4.999994
        end

        def to_unsafe
          @buffer
        end
      end
    end
  end
end
