module Lirith
  module Systems
    abstract class Base
      def handle_event(event : Events::Base)
      end
    end
  end
end
