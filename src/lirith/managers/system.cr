module Lirith
    module Managers
        class System
            @systems = [] of Core::Systems::Base

            def initialize
            end

            def register(system : Core::Systems::Base)
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

            def self.instance
                @@instance ||= new
            end
        end
    end
end