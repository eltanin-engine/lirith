module Lirith
  module Math
    struct TFace3(T) < TBase(T)
      @buffer : T*

      buffer_property :a, 0
      buffer_property :b, 1
      buffer_property :c, 2
    end
  end
end
