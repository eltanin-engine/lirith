module Lirith
  module Application
    module Systems
      class Window < Base
        def initialize
          @window = Core::Windows::GLFW.new
        end

        def shut_down
          LibGLFW.terminate

          true
        end

        def update
          LibGLFW.poll_events
        end

        def swap_buffers
          @window.swap_buffers
        end

        def handle_event(event)
          case event
          when Event::RenderStart   ; update
          when Event::RenderFinalize; swap_buffers
          end
        end
      end
    end
  end
end
