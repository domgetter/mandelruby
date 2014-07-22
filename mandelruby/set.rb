module Mandelruby

  class Set

    def initialize(color = false)
      @window = Window.new
      @mandelbrot = Mandelbrot.new(color)
    end

    def to_s
      @window.rows.map { |y|
        @window.columns.map { |x| 
          @mandelbrot.calculate(Complex(x,y)) 
        }.join("")
      }.join("\n")
    end

  end

  class Mandelbrot
    CHARACTERS = ["X","O","#","*","o","%","=","-","."]

    def initialize(color)
      # maximum iterations the recursive loop tries before bailing out and
      # considers a point in the set
      @dwell = 100
      #how many iterations before output uses a different character for bail levels
      @character_resolution = 2
      # only display color output if --color option passed
      @crayon = color ? Crayon.new : NullCrayon.new
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
      @crayon.color_in(character, order)
    end

    def order
      quotient = @iteration/@character_resolution
      quotient > 8 ? 8 : quotient
    end

  end

  class Window

    attr_reader :top_left, :bottom_right, :resolution
    def initialize
      # display window from top-left corner to bottom-right corner of complex plane
      @top_left = Pixel.new(-2.5, 1.0)
      @bottom_right = Pixel.new(1.5, -1.0)

      #resolution of characters in output
      @resolution = Pixel.new(80.0, 40.0)
    end
    
    def rows
      top_left.y.step(bottom_right.y, y_increment).to_a
    end

    def columns
      top_left.x.step(bottom_right.x, x_increment).to_a
    end

    private

    def x_increment
      (bottom_right.x - top_left.x) / resolution.x
    end

    def y_increment
      (bottom_right.y - top_left.y) / resolution.y
    end

  end

  class Pixel

    attr_reader :x, :y
    def initialize(x, y)
      @x, @y = x, y
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

  class NullCrayon
    def color_in(character, *args)
      character
    end
  end

end
