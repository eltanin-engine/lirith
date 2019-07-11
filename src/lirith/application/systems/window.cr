module Lirith
  module Application
    module Systems
      class Window < Core::Systems::Base
        enum Event
          Close
        end

        def initialize
        end

        def shut_down
          LibGLFW.terminate
          Managers::System.trigger_event(Event::Close)

          true
        end

        def update
          LibGLFW.poll_events
        end

        def swap_buffers
          Application::CORE.window.swap_buffers
          # @window.swap_buffers
        end

        def handle_event(event, payload)
          case event
          when Render::Event::PaintStart   ; update
          when Render::Event::PaintFinalize; swap_buffers
          when Render::Event::Stopped      ; shut_down
          end
        end
      end
    end
  end
end
