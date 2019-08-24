module Lirith
  module Singleton
    macro included
      def self.instance
        @@instance ||= new
      end
    end

    def dup
      raise "Singletons can't be duped"
    end

    def clone
      raise "Singletons can't be cloned"
    end
  end
end
