module Lirith
  module Managers
    class System
      @systems = [] of Systems::Base
      @event_queue = [] of Events::Base

      @event_channel = Channel(Nil).new
      @halt = false

      def initialize
        # register(Systems::Application.new)
      end

      def register(system : Systems::Base)
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

      def run
        spawn_event_handler

        @event_channel.receive
      end

      def stop
        @halt = true
      end

      def stop!
        @halt = true
        @event_channel.send(nil)
      end

      def spawn_event_handler
        spawn do
          loop do
            if event = @event_queue.shift?
              each { |system| system.handle_event(event) }
            end

            @event_channel.send(nil) if @halt && @event_queue.empty?
          end
        end
      end

      def self.instance
        @@instance ||= new
      end

      def trigger_event(event : Events::Base)
        @event_queue << event
      end

      def trigger_event(event_class : Class)
        trigger_event(event_class.new)
      end

      def trigger_direct_event(event : Events::Base)
        each { |system| system.handle_event(event) }
      end

      def trigger_direct_event(event_class : Class)
        trigger_direct_event(event_class.new)
      end

      def self.register(system : Systems::Base)
        self.instance.register(system)
      end

      def self.trigger_event(event : Events::Base)
        self.instance.trigger_event(event)
      end

      def self.trigger_event(event_class : Class)
        self.instance.trigger_event(event_class)
      end

      def self.trigger_direct_event(event : Events::Base)
        self.instance.trigger_direct_event(event)
      end

      def self.trigger_direct_event(event_class : Class)
        self.instance.trigger_direct_event(event_class)
      end
    end
  end
end
