module Lirith
  module Core
    module Renderers
      abstract class Base
        abstract def render(*args)
      end
    end
  end
end
