module Lirith
  module Events
    module Input
      abstract struct KeyEvent < Base
        getter key : Lirith::Input::Keys

        def initialize(@key)
        end

        def info
          "#{self.class} (#{@key})"
        end
      end

      struct KeyPressed < KeyEvent
      end

      struct KeyReleased < KeyEvent
      end
    end
  end
end
