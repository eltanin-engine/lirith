require "./base"
require "json"

module Lirith
  module Loaders
    class JsonLoader < Base
      enum Formats
        Basic
      end

      def load(file : File, format = Formats::Basic) : Objects::Mesh
        case format
        when Formats::Basic; load_basic(file)
        else                 raise "Format unknown"
        end
      end

      def load_basic(file)
        object = BasicFormat.from_json(file.gets_to_end)

        mesh = Objects::Mesh.new

        vector_count = object.vertices.size / 3

        0.upto(vector_count - 1) do |i|
          mesh.vertices << Vertex.new(
            Math::Vector3.new(
              object.vertices[i * 3],
              object.vertices[(i * 3) + 1],
              object.vertices[(i * 3) + 2]
            ),
            Math::Color.new(
              object.colors[i * 3],
              object.colors[(i * 3) + 1],
              object.colors[(i * 3) + 2]
            )
          )
        end

        mesh.material = Materials::Base.new
        mesh
      end

      struct BasicFormat
        JSON.mapping(
          vertices: {type: Array(Float32), setter: false},
          colors: {type: Array(Float32), setter: false},
          uv: {type: Array(Float32), setter: false}
        )
      end
    end
  end
end
