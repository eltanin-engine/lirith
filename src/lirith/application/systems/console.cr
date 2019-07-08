module Lirith
  module Application
    module Systems
      class Console < Core::Systems::Base
        # property polling = false
        property log = false

        def initialize
          @ignore_events = [
            Event::RenderPaintStart,
            Event::RenderPaintEnd,
            Event::RenderPaintFinalize,
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

        def handle_event(event)
          p event if @log && !@ignore_events.includes?(event)

          case event
          when Event::ConsoleAskCommand; get_command
          when Event::ConsoleToggleLog ; @log = !@log
            # when Event::RenderStopped; @polling = false
          end
        end
      end
    end
  end
end
