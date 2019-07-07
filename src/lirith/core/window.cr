module Lirith
  module Core
    class Window
      property height
      property width
      property title

      def initialize(@width = 1024, @height = 768, @title = "")
        raise "Failed to initialize GLFW" unless LibGLFW.init

        LibGLFW.window_hint LibGLFW::SAMPLES, 4
        LibGLFW.window_hint LibGLFW::CONTEXT_VERSION_MAJOR, 3
        LibGLFW.window_hint LibGLFW::CONTEXT_VERSION_MINOR, 3
        LibGLFW.window_hint LibGLFW::OPENGL_FORWARD_COMPAT, 1
        LibGLFW.window_hint LibGLFW::OPENGL_PROFILE, LibGLFW::OPENGL_CORE_PROFILE

        @handle = LibGLFW.create_window(width, height, title, nil, nil)

        set_current_context
        # LibGLFW.set_key_callback

        Managers::System.trigger_event(Event::WindowOpen)
        puts "OpenGL version: " + String.new(LibGL.get_string(LibGL::E_VERSION))
      end

      def handle : LibGLFW::Window
        if handle = @handle
          return handle
        else
          raise "No handle is set"
        end
      end

      def swap_buffers
        LibGLFW.swap_buffers handle
      end

      protected def set_current_context
        @handle.try do |handle|
          LibGLFW.set_current_context handle
        end
      end
    end
  end
end
