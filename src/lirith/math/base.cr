module Lirith
  module Math
    abstract struct Base
      macro buffer_property(name, key, type)
        def {{name.id}}
          @buffer[{{key}}]
        end

        def {{name.id}}=(value)
          @buffer[{{key}}] = {{type}}.new(value)
        end
      end
    end
  end
end
