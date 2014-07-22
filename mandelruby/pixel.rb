module Mandelruby
  class Pixel
    attr_reader :x, :y
    def initialize(x, y)
      @x, @y = x, y
    end

    def to_c
      Complex(x,y)
    end
  end
end
