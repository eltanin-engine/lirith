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
          @renderer = Core::Renderers::OpenGL.new
        end

        def run
          @running = true
          Managers::System.trigger_event(Event::Start)

          while (@running)
            Managers::System.trigger_event(Event::PaintStart)

            Managers::System.trigger_event(Event::PaintEnd)
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
