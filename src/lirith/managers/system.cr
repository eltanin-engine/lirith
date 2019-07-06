module Lirith
  module Managers
    class System
      @systems = [] of Application::Systems::Base

      def initialize
      end

      def register(system : Application::Systems::Base)
        @systems << system
      end

      def get(system_type : T.class) forall T
        @systems.each do |system|
          return system.as(T) if system.class == system_type
        end

        raise "System not found"
      end

      def each
        @systems.each do |system|
          yield system
        end
      end

      def trigger_event(event)
        each { |system| system.handle_event(event) }
      end

      def self.instance
        @@instance ||= new
      end

      def self.trigger_event(event)
        self.instance.trigger_event(event)
      end
    end
  end
end
