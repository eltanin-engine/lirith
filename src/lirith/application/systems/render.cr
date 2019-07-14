module Lirith
  module Application
    module Systems
      class Render < Core::Systems::Base
        getter running = false

        def initialize
        end

        def run
          @running = true
          Managers::System.trigger_event(Events::Render::Started)

          while (@running)
            Managers::System.trigger_event(Events::Render::StartPaint)

            Managers::System.trigger_event(Events::Render::EndPaint)

            Lirith::Application::CORE.renderer.render(Lirith::Application::CORE.scene, Lirith::Application::CORE.camera)
            LibGL.polygon_mode(LibGL::E_FRONT_AND_BACK, LibGL::E_LINE)
            LibGL.draw_arrays LibGL::E_TRIANGLES, 0, 12*3

            Managers::System.trigger_event(Events::Render::FinalizePaint)
          end

          Managers::System.trigger_event(Events::Render::Stopped)
        end

        def handle_event(event)
          case event
          when Core::Events::Application::Initialized; run
          when Core::Events::Application::Exit       ; @running = false
          end
        end
      end
    end
  end
end
