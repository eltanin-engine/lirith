module Lirith
  class Clock
    property? auto_start
    getter? running = false

    getter start_time = 0_i64
    getter last_time = 0_i64
    getter elapsed_time = 0_f64

    # for getting the delta times
    def initialize(@auto_start = true)
    end

    def start
      @start_time = @last_time = Time.now.epoch_ms
      @running = true
    end

    def stop
      elapsed_time
      @running = false
    end

    def elapsed_time
      get_delta
      @elapsed_time
    end

    def delta
      diff = 0

      start if !running? && @auto_start

      if running?
        current_time = Time.now.epoch_ms
        diff = (current_time - @last_time) / 1000.0
        @last_time = current_time
        @elapsed_time += diff
      end

      diff
    end


  end
end
