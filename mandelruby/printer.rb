require_relative 'calculator'

module Mandelruby
  class Printer
    CHARACTERS = ["X","O","#","*","o","%","=","-","."]

    attr_reader :dwell, :cartridge, :calculator
    def initialize(cartridge)
      # maximum iterations the loop tries before bailing out and
      # considers a point in the set
      @dwell = 100
      # only display color output if --color option passed
      @cartridge = cartridge
      @calculator = Calculator.new(CHARACTERS.size)
    end

    def print_pixel(pixel)
      index = calculator.mandelbrot_index(pixel.to_c)
      return " " unless index

      character = CHARACTERS[index]
      cartridge.print(character, index)
    end
  end
end
