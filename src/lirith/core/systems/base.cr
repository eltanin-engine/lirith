module Lirith
  module Core
    module Systems
      abstract class Base
        def handle_event(event, payload)
        end
      end
    end
  end
end
