require_relative 'crayons'

module Mandelruby

  class Set

    def initialize(color = false)
      @window = Window.new
      crayon = color ? Crayon.new : NullCrayon.new
      @mandelbrot = Mandelbrot.new(crayon)
    end

    def to_s
      @window.rows.map { |pixel_row|
        pixel_row.map { |pixel| pixel.to_mandelbrot(@mandelbrot) }.join("")
      }.join("\n")
    end

  end

  class Mandelbrot
    CHARACTERS = ["X","O","#","*","o","%","=","-","."]

    def initialize(crayon)
      # maximum iterations the recursive loop tries before bailing out and
      # considers a point in the set
      @dwell = 100
      #how many iterations before output uses a different character for bail levels
      @character_resolution = 2
      # only display color output if --color option passed
      @crayon = crayon
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
      y_axis.map do |y_coord|
        x_axis.map { |x_coord| Pixel.new(x_coord, y_coord) }
      end
    end

    private

    def x_axis
      interval = (bottom_right.x - top_left.x) / resolution.x
      (top_left.x .. bottom_right.x).step(interval)
    end

    def y_axis
      interval = (top_left.y - bottom_right.y) / resolution.y
      (bottom_right.y .. top_left.y).step(interval).reverse_each
    end

  end

  class Pixel

    attr_reader :x, :y
    def initialize(x, y)
      @x, @y = x, y
    end

    def to_mandelbrot(calculator)
      calculator.calculate(Complex(x,y))
    end

  end

end
