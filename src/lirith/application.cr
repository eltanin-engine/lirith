module Lirith
  module Application
    CORE = Core::Systems::Application.new

    enum Event
      InitializationCompleted
      Exit
    end
    # def core
    #    @@core ||= Systems::Application.new
    # end
  end
end

require "./application/*"
