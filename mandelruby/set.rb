module Mandelruby
  Point = Struct.new(:x, :y)

  class Set

    def initialize(options = {})
      options[:center] ||= [-0.5, 0.0]
      options[:zoom] ||= -0.3
      options[:color] ||= false
      options[:dwell] ||= 50
      @output = ""
      
      # maximum iterations the recursive loop tries before bailing out and
      # considers a point in the set
      @dwell = options[:dwell]
      
      #resolution of characters in output
      @resolution = [80.0,40.0]
      
      # center point of window on complex plane
      @center = Point.new(options[:center][0].to_f, options[:center][1].to_f)
      
      # logarithmic zoom level. each increment of 1 will double the zoom
      @zoom = options[:zoom]
      
      # how many iterations before output uses a different character for bail levels
      @character_resolution = 1
      
      # offset of character array.  userful for zoomed in views
      @character_offset = 2
      
      # chooses a number between 15 and 240 for the starting color
      @bg_color = rand(15..240)
      @fg_color = rand(15..240)
      
      # only display color output if --color option passed
      @color = options[:color]
    end

    def draw
      each_pixel do |x,y|
        @output += "\n" if new_row?
        mandelbrot(Complex(x,y))
        @output += character_for_iteration
      end
      @output
    end

    private

    def new_row?
      @new_row
    end

    def each_pixel
      rows.each do |y|
        columns.each do |x|
          yield x,y
          @new_row = false
        end
        @new_row = true
      end
    end

    def color_for_iteration
      bg_color + fg_color
    end

    def bg_color
      ["\e[48;5;", (@bg_color + color_index), "m"].join
    end

    def fg_color
      ["\e[38;5;", (@fg_color + color_index), "m"].join
    end

    def reset_color
      "\e[0m"
    end

    def color_index
      char_list.index(char_list[@iteration/@character_resolution-@character_offset]) || 8
    end

    def character_for_iteration
      return " " if @iteration == @dwell
      
      if @color
        color_for_iteration + (char_list[@iteration/@character_resolution-@character_offset] || ".") + reset_color
      else
        char_list[@iteration/@character_resolution-@character_offset] || "."
      end
    end

    def mandelbrot(c)
      z = 0
      @iteration = 0
      @dwell.times { z = z**2 + c; @iteration += 1; break if (z.abs >= 2)}
    end

    def char_list
      @char_list ||= ["X","O","#","*","o","%","=","-","."]
    end

    def x_increment
      domain/@resolution[0]
    end

    def y_increment
      range/@resolution[1]
    end

    def columns
      x_values.to_a
    end

    def rows
      y_values.to_a
    end

    def x_values
      left.step(right, x_increment)
    end

    def y_values
      top.step(bottom, -y_increment)
    end

    def domain
      right - left
    end

    def range
      top - bottom
    end

    def top
      (@center.y + 1.0/2**@zoom)
    end

    def bottom
      (@center.y - 1.0/2**@zoom)
    end

    def left
      (@center.x - 2.0/2**@zoom)
    end

    def right
      (@center.x + 2.0/2**@zoom)
    end

  end

end
