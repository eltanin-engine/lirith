require "./base"

module Lirith
  module Objects
    class Mesh < Base
      property vertices = Array(Vertex).new
      property colors = Array(Math::Color).new
      property faces = Array(Face).new

      property material = Materials::Basic.new

      def initialize
      end

      def clone
        mesh = super

        mesh.vertices = @vertices.clone
        mesh.colors = @colors.clone
        mesh.material = @material.clone

        mesh
      end
    end
  end
end
