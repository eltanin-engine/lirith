require "benchmark"

class Simple
  @counter = 0

  def call
    @counter += 1
  end

  def self.instance
    @@instance ||= new
  end
end

class Foo
  def call_simple
    Simple.instance.call
  end
end

class Bar
  @simple_ptr : Pointer(Simple)

  def initialize(simple)
    @simple_ptr = pointerof(simple)
  end

  def call_simple
    @simple_ptr.as(Simple).call
  end
end

Simple.instance

foo = Foo.new
bar = Bar.new(Simple.instance)

# Benchmark.ips(warmup: 4, calculation: 10) do |x|
#    x.report("Bar call") { bar.call_simple }
#    x.report("Foo call") { foo.call_simple }
# end
