module Lirith
  module Application
    CORE = Core::Systems::Application.new
    # def core
    #    @@core ||= Core::Systems::Application.new
    # end
  end
end

require "./application/*"
