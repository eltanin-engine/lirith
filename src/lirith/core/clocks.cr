module Lirith
  module Core
    module Clocks
      enum Event
        Start
        Stop
      end
    end
  end
end

require "./clocks/base"
require "./clocks/game"
