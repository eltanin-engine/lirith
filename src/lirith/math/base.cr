module Lirith
  module Math
    abstract struct Base
      macro buffer(type, properties)
        @buffer = Pointer({{type}}).malloc({{properties.size}})

        {% for property, index in properties %}
          def {{property.id}}
            @buffer[{{index}}]
          end

          def {{property.id}}=(value)
            @buffer[{{index}}] = {{type}}.new(value)
          end
        {% end %}

        def to_unsafe
          @buffer
        end

        def to_slice
          @buffer.as(UInt8*).to_slice(buffer_size)
        end

        def property_size
          self.class.property_size
        end

        def self.property_size
          {{properties.size}}
        end

        def buffer_size
          self.class.buffer_size
        end

        def self.buffer_size
          sizeof({{type}}) * {{properties.size}}
        end

        def inspect
          "#{self.class}({{properties.map { |p| ("\#{" + p.stringify + "}").id }.splat}})"
        end
      end

      macro simple_initialize(name, *parameters)
        def self.{{name.id}}
          new({{parameters.splat}})
        end
      end
    end
  end
end
