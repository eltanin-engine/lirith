#require "lib_glew"
#require "glfw"
require "./lirith/*"
require "lib_glfw"
require "lib_gl"
#require "lib_glew"

module Lirith
end


class TestApp < Lirith::Application
end

app = TestApp.new
app.run