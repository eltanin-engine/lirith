require "glfw"
module Lirith
  module Windows
    class GLFW < BaseWindow
      # For the control callbacks
      getter window

      def initialize(@width = 1024, @height = 768, @title = "")
        @window = ::GLFW::Window.new(@width, @height, @title)
        @window.set_context_current
      end

      def loop(&block)
        @window.open &block
      end
    end
  end
end
