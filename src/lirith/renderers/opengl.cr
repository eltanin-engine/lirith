require "opengl"
module Lirith
  module Renderers
    class OpenGL < BaseRenderer

      def initialize(settings = {} of Symbol => String|Int32|Float32)
        create_window
      end

      def create_window
        @window = Windows::GLFW.new(width, height, title)
      end
      
      def render
        #p "Frame"
      end
    end
  end
end
