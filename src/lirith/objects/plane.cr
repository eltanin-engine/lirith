require "./mesh"

module Lirith
  module Objects
    module Plane
      def self.create(width = 1, height = 1, width_segments = 1, height_segments = 1)
        segment_width = width.to_f32 / width_segments
        segment_height = height.to_f32 / height_segments

        mesh = Objects::Mesh.new

        0.upto(width_segments - 1) do |ix|
          0.upto(height_segments - 1) do |iy|
            # Face 1
            mesh.vertices << Vertex.new(
              Math::Vector3.new(segment_width * ix, segment_height * iy, 0),
              Math::Vector2.new(0, 0),
              Math::Color.black
            )
            mesh.vertices << Vertex.new(
              Math::Vector3.new(segment_width * ix, segment_height * (iy + 1), 0),
              Math::Vector2.new(0, 1),
              Math::Color.black
            )
            mesh.vertices << Vertex.new(
              Math::Vector3.new(segment_width * (ix + 1), segment_height * iy, 0),
              Math::Vector2.new(1, 0),
              Math::Color.black
            )

            # Face 2
            mesh.vertices << Vertex.new(
              Math::Vector3.new(segment_width * ix, segment_height * (iy + 1), 0),
              Math::Vector2.new(0, 1),
              Math::Color.red
            )
            mesh.vertices << Vertex.new(
              Math::Vector3.new(segment_width * (ix + 1), segment_height * (iy + 1), 0),
              Math::Vector2.new(1, 1),
              Math::Color.red
            )
            mesh.vertices << Vertex.new(
              Math::Vector3.new(segment_width * (ix + 1), segment_height * iy, 0),
              Math::Vector2.new(1, 0),
              Math::Color.red
            )
          end
        end

        # mesh.material = Materials::Base.new
        mesh
      end
    end
  end
end
