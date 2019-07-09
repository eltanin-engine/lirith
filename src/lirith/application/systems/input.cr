module Lirith
  module Application
    module Systems
      class Input < Core::Systems::Base
        def handle_key_press(key)
          case key
          when Core::Input::Keys::KeyGraveAccent; Managers::System.trigger_event(Event::ConsoleAskCommand)
          when Core::Input::Keys::KeyEscape     ; Managers::System.trigger_event(Event::ApplicationExit)
          end
        end

        def handle_event(event, payload)
          case event
          when Event::InputKeyPress; handle_key_press(payload)
          end
        end
      end
    end
  end
end
