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
      @iteration = iteration_for(c)
      character_for_iteration
    end

    def iteration_for(complex)
      (1..100).inject(0) do |z, iteration|
        break 100 if iteration == 100
        break iteration-1 if z.abs >= 2
        z**2 + complex
      end
    end

    def character_for_iteration
      return " " if @iteration == 100
      character = CHARACTERS[order]
      @cartridge.color_in(character, order)
    end

    def order
      quotient = @iteration/@character_resolution
      quotient > 8 ? 8 : quotient
    end
  end
end
