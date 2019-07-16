module Lirith
  module Windows
    abstract class BaseWindow
      property width = 1024
      property height = 768
      property title = ""
      property! controls : Lirith::Controls::BaseControls

      abstract def loop(&block)
    end
  end
end
