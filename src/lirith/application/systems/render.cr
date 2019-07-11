module Lirith
  module Application
    module Systems
      class Render < Core::Systems::Base
        enum Event
          Start
          PaintStart
          PaintEnd
          PaintFinalize
          Stopped
        end

        getter running = false

        def initialize
        end

        def run
          @running = true
          Managers::System.trigger_event(Event::Start)

          while (@running)
            Managers::System.trigger_event(Event::PaintStart)

            Managers::System.trigger_event(Event::PaintEnd)

            Lirith::Application::CORE.renderer.render(Lirith::Application::CORE.scene)
            LibGL.polygon_mode( LibGL::E_FRONT_AND_BACK, LibGL::E_LINE );
            LibGL.draw_arrays LibGL::E_TRIANGLES, 0, 12*3

            Managers::System.trigger_event(Event::PaintFinalize)
          end

          Managers::System.trigger_event(Event::Stopped)
        end

        def handle_event(event, payload)
          case event
          when Application::Event::InitializationCompleted; run
          when Application::Event::Exit                   ; @running = false
          end
        end
      end
    end
  end
end
