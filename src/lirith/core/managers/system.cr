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

        def trigger_event(event, payload = nil)
          each { |system| system.handle_event(event, payload) }
        end

        def self.instance
          @@instance ||= new
        end

        def self.register(system : Systems::Base)
          self.instance.register(system)
        end

        def self.trigger_event(event, payload = nil)
          self.instance.trigger_event(event, payload)
        end
      end
    end
  end
end
