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
        # params = line_params_i(line).in_groups_of(1)
        vertices = [] of Vertex

        params = line.scan(/[\d\/]+/).map(&.[0].split('/').map(&.to_i))
        faces = [] of Array(Array(Int32))

        v1 = params[0]
        (1..(params.size - 2)).each do |i|
          v2 = params[i]
          v3 = params[i + 1]

          faces << [v1, v2, v3]
        end

        faces.each do |face|
          face.each do |vertex|
            vector = vectors[vertex[0].not_nil! - 1].clone

            uv = if (vertex.size > 1)
                   uvs[vertex[1].not_nil! - 1].clone
                 else
                   Math::Vector2.new(0, 0)
                 end

            color = Math::Color.black

            vertices << Vertex.new(vector, uv, color)
          end
        end

        vertices
      end
    end
  end
end
