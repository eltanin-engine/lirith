module Lirith
  class Window
    property height
    property width
    property title

    def initialize(@width = 1024, @height = 768, @title = "", fullscreen = false)
      raise "Failed to initialize GLFW" unless LibGLFW.init

      LibGLFW.window_hint LibGLFW::SAMPLES, 4
      LibGLFW.window_hint LibGLFW::CONTEXT_VERSION_MAJOR, 3
      LibGLFW.window_hint LibGLFW::CONTEXT_VERSION_MINOR, 3
      LibGLFW.window_hint LibGLFW::OPENGL_FORWARD_COMPAT, 1
      LibGLFW.window_hint LibGLFW::OPENGL_PROFILE, LibGLFW::OPENGL_CORE_PROFILE



      @handle = if fullscreen
        monitor = LibGLFW.primary_monitor
        mode = LibGLFW.video_mode(monitor).value

        LibGLFW.window_hint(LibGLFW::RED_BITS, mode.red_bits);
        LibGLFW.window_hint(LibGLFW::GREEN_BITS, mode.green_bits);
        LibGLFW.window_hint(LibGLFW::BLUE_BITS, mode.blue_bits);
        LibGLFW.window_hint(LibGLFW::REFRESH_RATE, mode.refresh_rate);

        @width = mode.width
        @height = mode.height

        LibGLFW.create_window(mode.width, mode.height, title, monitor, nil)
        #LibGLFW.create_window(width, height, title, nil, nil)
      else
        LibGLFW.create_window(width, height, title, nil, nil)
      end

      set_current_context

      LibGLFW.set_input_mode @handle, LibGLFW::STICKY_KEYS, 1
      # LibGLFW.set_input_mode @handle, LibGLFW::CURSOR, LibGLFW::CURSOR_DISABLED

      set_callbacks

      Managers::System.trigger_event(Events::Window::Opened)
      puts "OpenGL version: " + String.new(LibGL.get_string(LibGL::E_VERSION))
      puts "Window init #{@width}x#{@height}"
    end

    def handle : LibGLFW::Window
      if handle = @handle
        return handle
      else
        raise "No handle is set"
      end
    end

    def set_callbacks
      self.class.key_callback(handle, ->Input.handle_key(LibGLFW::Window, Int32, Int32, Int32, Int32))
    end

    def swap_buffers
      LibGLFW.swap_buffers handle
    end

    protected def set_current_context
      @handle.try do |handle|
        LibGLFW.make_context_current handle
      end
    end

    def self.key_callback(handle : LibGLFW::Window, callback : Proc(LibGLFW::Window, Int32, Int32, Int32, Int32, Void))
      LibGLFW.set_key_callback(handle, callback)
    end
  end
end
