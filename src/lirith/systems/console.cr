module Lirith
  module Systems
    class Console < Lirith::Systems::Base
      # property polling = false
      property log = true

      def initialize
        @ignore_events = [ # Events::Render::StartPaint,
        # Events::Render::EndPaint,
        # Events::Render::FinalizePaint,
] of Events::Base
      end

      def get_command
        print "Command: "
        line = gets.to_s
        # if event = Event.parse?(line)
        #  Managers::System.trigger_event(event)
        # else
        p "Command '#{line}' was not found"
        # end
      end

      def handle_event(event)
        p event.info if @log && !@ignore_events.includes?(event.class)
        case event
        when Events::Console::RequestCommand; get_command
        when Events::Console::ToggleLog     ; @log = !@log
        end
      end
    end
  end
end
