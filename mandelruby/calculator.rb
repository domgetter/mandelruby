module Mandelruby
  class Calculator
    attr_reader :character_resolution, :max_index
    def initialize(number_of_characters)
      @character_resolution = 2
      @max_index = number_of_characters - 1
    end

    def mandelbrot_index(complex)
      iteration = iteration_for(complex)
      return nil if iteration == :overdwell

      quotient = iteration / character_resolution
      quotient > max_index ? max_index : quotient
    end

    private

    def iteration_for(complex)
      (1..100).inject(0) do |z, iteration|
        break :overdwell if iteration == 100
        break iteration-1 if z.abs >= 2
        z**2 + complex
      end
    end
  end
end
