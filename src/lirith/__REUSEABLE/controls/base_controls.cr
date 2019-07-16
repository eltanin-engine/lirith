module Lirith
  module Controls
    abstract class BaseControls
      def initialize # (@camera : Lirith::Camera)
      end

      def key_press(key)
      end

      abstract def update(delta, scene)
    end
  end
end
