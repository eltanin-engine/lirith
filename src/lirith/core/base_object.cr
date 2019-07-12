module Lirith
  module Core
    class BaseObject
      property position = Math::Vector3.zero
      property quaternation = "need to implement"
      property scale = Math::Vector3.zero

      property children = [] of self

      def initialize
      end
    end
  end
end
