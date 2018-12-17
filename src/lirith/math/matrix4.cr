module Lirith
  module Math
    struct TMatrix4(T) < TBase(T)
      @buffer : T*

      def initialize
        @buffer = Pointer(T).malloc(16)
      end

      def buffer
        @buffer
      end

      def to_unsafe
        @buffer
      end

      def ==(matrix : TMatrix4(T))
        0.upto(15) { |i|
          return false if @buffer[i] != matrix.buffer[i]
        }
        return true
      end

      def !=(m : TMatrix4(T))
        !(self == m)
      end

      def *(v)
        m = TMatrix4(T).new
        0.upto(15) { |i|
          m.buffer[i] = @buffer[i] * v
        }
        m
      end

      def *(m : TMatrix4(T))
        r = TMatrix4(T).new_with_row_col { |i, j|
          p1 = @buffer + i
          p2 = m.buffer + 4*j
          p1[0] * p2[0] + p1[4] * p2[1] + p1[8] * p2[2] + p1[12] * p2[3]
        }
        r
      end

      def [](i)
        raise IndexError.new if i < 0 || i >= 16
        @buffer[i]
      end

      def [](row, col)
        self[row + col*4]
      end

      def []=(i, value : T)
        raise IndexError.new if i < 0 || i >= 16
        @buffer[i] = value
      end

      def []=(row, col, value : T)
        self[row + col*4] = value
      end

      def self.new(&block : Int32 -> T)
        matrix = TMatrix4(T).new
        pointer = matrix.buffer
        0.upto(15) { |i|
          matrix[i] = yield i
        }
        matrix
      end

      def self.new_with_row_col(&block : (Int32, Int32) -> T)
        m = TMatrix4(T).new
        p = m.buffer
        0.upto(3) { |i|
          0.upto(3) { |j|
            p[i + 4*j] = yield i, j
          }
        }
        m
      end

      def self.zero
        TMatrix4(T).new { T.zero }
      end

      def self.identity
        m = zero
        m[0] = m[5] = m[10] = m[15] = T.new(1)
        m
      end
    end
  end
end
