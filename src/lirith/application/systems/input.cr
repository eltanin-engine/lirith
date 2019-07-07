module Lirith
  module Application
    module Systems
      class Input < Core::Systems::Base
        def check_input
          if LibGLFW.get_key(Application::CORE.window.handle, LibGLFW::KEY_ESCAPE) == LibGLFW::PRESS
            Managers::System.trigger_event(Event::ApplicationExit)
          end
        end

        def handle_event(event)
          case event
          when Event::RenderEnd; check_input
          end
        end
      end
    end
  end
end
