require "./base"

module Lirith
  module Systems
    class Application < Base
      def run
      end

      def shutdown
        Managers::System.instance.stop
      end

      def handle_event(event)
        case event
        when Events::Application::Initialized; run
        when Events::Application::Exit       ; shutdown
        end
      end
    end
  end
end
