module Lirith
  module Controls
    abstract class BaseControls
      def initialize(@camera : Lirith::Camera)
      end

      abstract def update(delta)
    end
  end
end
