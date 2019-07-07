module Lirith
  module Application
    module Systems
      class Console < Core::Systems::Base
        def initialize
        end

        def handle_event(event)
          p event
        end
      end
    end
  end
end
