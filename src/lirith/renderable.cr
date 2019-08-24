require "./renderer/attributes"

module Lirith
  module Renderable
    property render_attributes : Renderer::Attributes?
    property? needs_update = true
  end
end
