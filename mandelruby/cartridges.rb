module Mandelruby
  class Black
    def print(character, *args)
      character
    end
  end

  class Color
    attr_reader :background, :foreground
    def initialize
      @background = rand(15..240)
      @foreground = rand(15..240)
    end

    def print(character, offset)
      bg_color(offset) + fg_color(offset) + character + reset_color
    end

    private

    def bg_color(offset)
      "\e[48;5;#{background + offset}m"
    end

    def fg_color(offset)
      "\e[38;5;#{foreground + offset}m"
    end

    def reset_color
      "\e[0m"
    end
  end
end
