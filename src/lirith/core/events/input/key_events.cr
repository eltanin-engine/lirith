module Lirith
  module Core
    module Events
      module Input
        abstract struct KeyEvent < Base
          getter key : Lirith::Core::Input::Keys

          def initialize(@key)
          end
        end

        struct KeyPressed < KeyEvent
        end

        struct KeyReleased < KeyEvent
        end
      end
    end
  end
end
