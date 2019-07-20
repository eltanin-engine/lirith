module Lirith
  module Objects
  abstract class Base
    property position = Math::Vector3.zero
    property quaternation = "need to implement"
    property scale = Math::Vector3.zero

    property children = [] of self

    property render_attributes : RenderAttributes?
  end
end
end
