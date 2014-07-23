module Mandelruby
  class Printer
    CHARACTERS = ["X","O","#","*","o","%","=","-","."]

    def initialize(cartridge)
      # maximum iterations the loop tries before bailing out and
      # considers a point in the set
      @dwell = 100
      # how many iterations before output uses a different character for bail levels
      @character_resolution = 2
      # only display color output if --color option passed
      @cartridge = cartridge
    end

    def print_pixel(pixel)
      complex_to_character(pixel.to_c)
    end

    private

    def complex_to_character(c)
      index = mandelbrot_index(c, CHARACTERS.size-1)
      return " " unless index

      character = CHARACTERS[index]
      @cartridge.color_in(character, index)
    end

    def iteration_for(complex)
      (1..100).inject(0) do |z, iteration|
        break :overdwell if iteration == 100
        break iteration-1 if z.abs >= 2
        z**2 + complex
      end
    end

    def mandelbrot_index(complex, max)
      iteration = iteration_for(complex)
      return nil if iteration == :overdwell

      quotient = iteration / @character_resolution
      quotient > max ? max : quotient
    end
  end
end
