module Lirith
  module Application
    module Systems
      class Render < Core::Systems::Base
        getter running = false

        def initialize
          @renderer = Core::Renderers::OpenGL.new
        end

        def run
          @running = true
          Managers::System.trigger_event(Event::RenderStart)

          while (@running)
            Managers::System.trigger_event(Event::RenderPaintStart)

            Managers::System.trigger_event(Event::RenderPaintEnd)
            Managers::System.trigger_event(Event::RenderPaintFinalize)
          end

          Managers::System.trigger_event(Event::RenderStopped)
        end

        def handle_event(event, payload)
          case event
          when Event::InitializationCompleted; run
          when Event::ApplicationExit        ; @running = false
          end
        end
      end
    end
  end
end
