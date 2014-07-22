module Mandelruby
  class Printer
    CHARACTERS = ["X","O","#","*","o","%","=","-","."]

    def initialize(cartridge)
      # maximum iterations the recursive loop tries before bailing out and
      # considers a point in the set
      @dwell = 100
      #how many iterations before output uses a different character for bail levels
      @character_resolution = 2
      # only display color output if --color option passed
      @cartridge = cartridge
    end

    def calculate(c)
      z = 0
      @iteration = 0
      @dwell.times { z = z**2 + c; @iteration += 1; break if (z.abs >= 2)}
      character_for_iteration
    end

    def character_for_iteration
      return " " if @iteration == @dwell
      character = CHARACTERS[order]
      @cartridge.color_in(character, order)
    end

    def order
      quotient = @iteration/@character_resolution
      quotient > 8 ? 8 : quotient
    end
  end
end
