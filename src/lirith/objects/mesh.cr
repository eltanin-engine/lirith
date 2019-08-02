require "./base"

module Lirith
  module Objects
    class Mesh < Base
      property vertices = Array(Vertex).new
      property material : Materials::Base?

      def initialize
      end
    end
  end
end
