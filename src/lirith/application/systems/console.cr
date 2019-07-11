module Lirith
  module Application
    module Systems
      class Console < Core::Systems::Base
        enum Event
          AskCommand
          ToggleLog
        end

        # property polling = false
        property log = true

        def initialize
          @ignore_events = [
            Render::Event::PaintStart,
            Render::Event::PaintEnd,
            Render::Event::PaintFinalize,
          ]
        end

        def get_command
          print "Command: "
          line = gets.to_s
          if event = Event.parse?(line)
            Managers::System.trigger_event(event)
          else
            p "Command '#{line}' was not found"
          end
        end

        def handle_event(event, payload)
          p "#{event.class}::#{event}" if @log && !@ignore_events.includes?(event)

          case event
          when Event::AskCommand; get_command
          when Event::ToggleLog ; @log = !@log
            # when Event::RenderStopped; @polling = false
          end
        end
      end
    end
  end
end
