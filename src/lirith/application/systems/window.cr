module Lirith
  module Application
    module Systems
      class Window < Core::Systems::Base
        def initialize
        end

        def shut_down
          LibGLFW.terminate
          Managers::System.trigger_event(Event::WindowClose)

          true
        end

        def update
          LibGLFW.poll_events
        end

        def swap_buffers
          Application::CORE.window.swap_buffers
          # @window.swap_buffers
        end

        def handle_event(event)
          case event
          when Event::RenderPaintStart   ; update
          when Event::RenderPaintFinalize; swap_buffers
          when Event::RenderStopped      ; shut_down
          end
        end
      end
    end
  end
end
