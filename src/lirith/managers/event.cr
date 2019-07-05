module Lirith
    module Managers
        class Event
            @callbacks = {} of String => Array(Proc(Nil))

            # Callbacks MUST return nil otherwise they wont work...
            def register(event : String, callback : Proc(Nil))
                if @callbacks.has_key? event
                    @callbacks[event] << callback
                else
                    @callbacks[event] = [callback]
                end

                p "Callback for event '#{event}'' added"
            end

            def register(event, &callback : -> Nil)
                register(event, callback)
            end

            def trigger(event)
                @callbacks[event].each(&.call) if @callbacks.has_key? event
                #p "Event '#{event}' triggered"
            end

            def self.instance
                @@instance ||= new
            end

            def self.trigger(event)
                instance.trigger(event)
            end
        end
    end
end