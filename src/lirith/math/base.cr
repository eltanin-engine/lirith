module Lirith
  module Math
    abstract struct TBase(T)
      macro buffer_property(name, key)
        def {{name.id}}
          @buffer[{{key}}]
        end

        def {{name.id}}=(value)
          @buffer[{{key}}] = value.as(T)
        end
      end
    end
  end
end
