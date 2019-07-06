module Lirith
  module Application
    module Systems
      abstract class Base
        def pre_render
        end

        def update
        end

        def handle_event(event)
        end
      end
    end
  end
end
