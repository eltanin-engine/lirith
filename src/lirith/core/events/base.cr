module Lirith
  module Core
    module Events
      abstract struct Base
        def info
          self.class.to_s
        end
      end
    end
  end
end

require "./application/*"
require "./input/*"
require "./window/*"
require "./render/*"
