module Lirith
  module Math
    abstract struct Base
      macro buffer_property(name, key)
        def {{name.id}}
          @buffer[{{key}}]
        end

        def {{name.id}}=(value)
          @buffer[{{key}}] = T.new(value)
        end
      end
    end
  end
end
