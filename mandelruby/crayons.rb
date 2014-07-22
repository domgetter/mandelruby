module Mandelruby
  class NullCrayon
    def color_in(character, *args)
      character
    end
  end

  class Crayon

    attr_reader :background, :foreground
    def initialize
      @background = rand(15..240)
      @foreground = rand(15..240)
    end

    def color_in(character, offset)
      bg_color(offset) + fg_color(offset) + character + reset_color
    end

    private

    def bg_color(offset)
      ["\e[48;5;", (background + offset), "m"].join
    end

    def fg_color(offset)
      ["\e[38;5;", (foreground + offset), "m"].join
    end

    def reset_color
      "\e[0m"
    end

  end
end
