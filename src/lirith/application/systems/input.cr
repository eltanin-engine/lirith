module Lirith
  module Application
    module Systems
      class Input < Core::Systems::Base
        def handle_key_press(key)
          case key
          when Core::Input::Keys::KeyGraveAccent; Managers::System.trigger_event(Events::Console::RequestCommand)
          when Core::Input::Keys::KeyEscape     ; Managers::System.trigger_event(Core::Events::Application::Exit)

          when Core::Input::Keys::W     ; Lirith::Application::CORE.camera.position.z -= 0.1
          when Core::Input::Keys::A     ; Lirith::Application::CORE.camera.position.x -= 0.1
          when Core::Input::Keys::S     ; Lirith::Application::CORE.camera.position.z += 0.1
          when Core::Input::Keys::D     ; Lirith::Application::CORE.camera.position.x += 0.1
          end
        end

        def handle_event(event : Core::Events::Base)
          case event
          when Core::Events::Input::KeyPressed; handle_key_press(event.key)
          end
        end
      end
    end
  end
end
