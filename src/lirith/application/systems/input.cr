module Lirith
  module Application
    module Systems
      class Input < Core::Systems::Base
        def handle_key_press(key)
          case key
          when Core::Input::Keys::KeyGraveAccent; Managers::System.trigger_event(Console::Event::AskCommand)
          when Core::Input::Keys::KeyEscape     ; Managers::System.trigger_event(Application::Event::Exit)
          end
        end

        def handle_event(event, payload)
          case event
          when Core::Input::Event::KeyPress; handle_key_press(payload)
          end
        end
      end
    end
  end
end
