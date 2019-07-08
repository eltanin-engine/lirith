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

        #self.class.key_callback(handle) do |window, key, scancode, action, mods|
        #  p key if action == LibGLFW::PRESS
        #end
      
        #pr = ->Input.handle_key(LibGLFW::Window*, Int32, Int32, Int32, Int32)
        #self.class.key_callback(handle, ->Input.handle_key(LibGLFW::Window*, Int32, Int32, Int32, Int32))

        #self.class.key_callback(handle, ->self.handle_key(LibGLFW::Window*, Int32, Int32, Int32, Int32))

        #
        pr = ->Lirith::Core::Window.handle_key(LibGLFW::Window*, Int32, Int32, Int32, Int32)
        p typeof(pr)
        self.class.key_callback(handle,  pr)
       Managers::System.trigger_event(Event::WindowOpen)
       puts "OpenGL version: " + String.new(LibGL.get_string(LibGL::E_VERSION))
      end

      def self.handle_key(window : LibGLFW::Window*, key : Int32, scancode : Int32, action : Int32, mods : Int32) : Nil
        p key if action == LibGLFW::PRESS
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

      def self.key_callback(handle : LibGLFW::Window, callback : Proc(LibGLFW::Window*, Int32, Int32, Int32, Int32, Void))
        #p typeof(callback)
        LibGLFW.set_key_callback(handle, callback)
      end
      
      #def self.key_callback(handle : LibGLFW::Window, &callback : LibGLFW::Window*, Int32, Int32, Int32, Int32 ->)
      #  p typeof(callback)
        #LibGLFW.set_key_callback(handle, callback)
      #end
    end
  end
end
