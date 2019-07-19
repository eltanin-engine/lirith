module Lirith
  abstract struct BaseObject
    property position = Math::Vector3.zero
    property quaternation = "need to implement"
    property scale = Math::Vector3.zero

    property children = [] of self
  end
end
