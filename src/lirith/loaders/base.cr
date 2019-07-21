module Lirith
  module Loaders
    abstract class Base
      def load(*args)
        raise "Load is not implemented for #{self.class}"
      end
    end
  end
end
