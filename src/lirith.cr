#require "lib_glew"
#require "glfw"
require "./lirith/*"
require "lib_glfw"
require "lib_gl"
#require "lib_glew"

module Lirith
  # TODO Put your code here
  def self.boot
    #window_manager = Managers::Window.new
    #controls_manager = Managers::Controls.new

    #window_manager.start_up
    #controls_manager.start_up(window_manager.handle)

    #background_color = [0.1, 0, 0, 1]

    #while true
    #  LibGLFW.poll_events
    #  break if LibGLFW.get_key(window_manager.handle, LibGLFW::KEY_ESCAPE) == LibGLFW::PRESS

    #  LibGL.clear_color background_color[0], background_color[1], background_color[2], background_color[3]
    #  LibGL.clear LibGL::E_COLOR_BUFFER_BIT | LibGL::E_DEPTH_BUFFER_BIT
    #  LibGLFW.swap_buffers window_manager.handle
    #end

    #controls_manager.shut_down
    #window_manager.shut_down
  end

end


class TestApp < Lirith::Application
end

app = TestApp.new
app.run