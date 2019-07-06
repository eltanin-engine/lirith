module Lirith
  module Application
    module Systems
      class Render < Base
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
        end

        def handle_event(event)
          case event
          when Event::InitializationCompleted; run
          when Event::WindowsClose           ; @running = false
          end
        end
      end
    end
  end
end
