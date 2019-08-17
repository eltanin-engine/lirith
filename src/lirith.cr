# require "lib_glew"
# require "glfw"
require "lib_glfw"
require "lib_gl"
require "r_image"

require "./lirith/*"

module Lirith
  class_property! application : Lirith::Application
end
