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

          while (@running)
            Managers::System.trigger_event(Event::RenderStart)

            Managers::System.trigger_event(Event::RenderEnd)
            Managers::System.trigger_event(Event::RenderFinalize)
          end

          Managers::System.trigger_event(Event::RenderStopped)
        end

        def handle_event(event)
          case event
          when Event::InitializationCompleted; run
          when Event::ApplicationExit        ; @running = false
          end
        end
      end
    end
  end
end
