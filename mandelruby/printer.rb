require_relative 'calculator'

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
      @calculator = Calculator.new(CHARACTERS.size)
    end

    def print_pixel(pixel)
      index = @calculator.mandelbrot_index(pixel.to_c)
      return " " unless index

      character = CHARACTERS[index]
      @cartridge.color_in(character, index)
    end
  end
end
