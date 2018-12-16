module Lirith
  module Renderers
    abstract class BaseRenderer
      property! window
      property width = 1024
      property height = 768
      property title = ""
      #abstract def render(&block)
    end
  end
end
