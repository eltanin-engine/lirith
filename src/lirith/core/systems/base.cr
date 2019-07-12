module Lirith
  module Core
    module Systems
      abstract class Base
        def handle_event(event : Enum, payload)
        end

        def handle_event(event : Events::Base)
        end
      end
    end
  end
end
