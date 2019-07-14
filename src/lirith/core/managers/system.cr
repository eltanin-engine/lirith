module Lirith
  module Core
    module Managers
      class System
        @systems = [] of Systems::Base

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

        def trigger_event(event : Events::Base)
          each { |system| system.handle_event(event) }
        end

        def trigger_event(event_class : Class)
          trigger_event(event_class.new)
        end

        def self.instance
          @@instance ||= new
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
      end
    end
  end
end
