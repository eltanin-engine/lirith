require "./base"

module Lirith
  module Objects
    class Mesh < Base
      property vertices = Array(Vertex).new
      property faces = Array(Face).new
      property material : Materials::Base?

      def initialize
      end

      def clone
        mesh = super

        mesh.vertices = @vertices.clone
        mesh.material = @material.clone

        mesh
      end
    end
  end
end
