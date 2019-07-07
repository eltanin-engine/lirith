module Lirith
  module Core
    module Systems
      class Application < Base
        getter window

        def initialize
          @window = Window.new
        end
      end
    end
  end
end
