# require "lib_glew"
# require "glfw"
require "lib_glfw"
require "lib_gl"

require "./lirith/core"
require "./lirith/application"
require "./lirith/event"
require "./lirith/base_app"
require "./lirith/version"

# require "lib_glew"

module Lirith
end

class TestApp < Lirith::BaseApp
end

app = TestApp.new
app.run
