require "./base"

module Lirith
  module Loaders
    class ObjLoader < Base
      def load(file : File)
        mesh = Objects::Mesh.new

        vector_cache = [] of Math::Vector3
        uv_cache = [] of Math::Vector2

        while line = file.gets
          case line
          when .starts_with?("v ") ; vector_cache << parse_vector(line)
          when .starts_with?("vt "); uv_cache << parse_uv(line)
          when .starts_with?("f ") ; mesh.vertices += parse_face(line, vector_cache, uv_cache)
          end
        end

        mesh
      end

      private def line_params_f(line : String)
        line.scan(/[-+]?([0-9]*\.[0-9]+|[0-9]+)/).map(&.[0].to_f)
      end

      private def line_params_i(line : String)
        line.scan(/\d+/).map(&.[0].to_i)
      end

      private def parse_vector(line : String)
        params = line_params_f(line)
        Math::Vector3.new(
          params[0],
          params[1],
          params[2]
        )
      end

      private def parse_uv(line : String)
        params = line_params_f(line)
        Math::Vector2.new(
          params[0],
          params[1]
        )
      end

      private def parse_face(line : String, vectors : Array(Math::Vector3), uvs : Array(Math::Vector2))
        params = line_params_i(line).in_groups_of(3)
        vertices = [] of Vertex

        params.each do |vertex|
          vertices << Vertex.new(
            vectors[vertex[0].not_nil! - 1].clone,
            uvs[vertex[1].not_nil! - 1].clone,
            Math::Color.black
          )
        end

        vertices
      end
    end
  end
end
