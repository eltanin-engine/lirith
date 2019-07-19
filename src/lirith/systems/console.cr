module Lirith
  module Systems
    class Console < Lirith::Systems::Base
      # property polling = false
      property log = true

      def initialize(@ignore_events = [] of Events::Base.class)
      end

      def get_command
        print "Command: "
        line = gets.to_s

        handle_command(line)
      end

      def handle_command(command)
        case command
        when "exit"; Managers::System.trigger_event(Events::Application::Exit)
        else; p "Command '#{command}' was not found"
        end
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
