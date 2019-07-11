module Lirith
  module Core
    module Renderers
      enum Event
        Started
        Completed
      end
    end
  end
end

require "./renderers/*"
