module Mandelruby

  class Set

    def initialize
      @output = ""
      # maximum iterations the recursive loop tries before bailing out and
      # considers a point in the set
      @dwell = 100
      #resolution of characters in output
      @resolution = [80.0,40.0]
      # display window from top-left corner to bottom-right corner of complex plane
      @window = [[-2.5, 1.0], [1.5, -1.0]]
      #how many iterations before output uses a different character for bail levels
      @character_resolution = 2
      # chooses a number between 15 and 240 for the starting colour
      @bg_colour = rand(15..240)
      @fg_colour = rand(15..240)
    end

    def draw
      each_pixel do |x,y|
        @output += "\n" if new_row?
        mandelbrot(Complex(x,y))
        @output += colour_for_iteration
        @output += character_for_iteration
        @output += reset_colour
      end
      @output += reset_colour
      @output
    end

    private

    def new_row?
      @new_row
    end

    def each_pixel
      column.each do |y|
        row.each do |x|
          yield x,y
          @new_row = false
        end
        @new_row = true
      end
    end

    def colour_for_iteration
      return reset_colour if @iteration == @dwell

      bg_colour + fg_colour
    end

    def bg_colour
      ["\e[48;5;", (@bg_colour + colour_index), "m"].join
    end

    def fg_colour
      ["\e[38;5;", (@fg_colour + colour_index), "m"].join
    end

    def reset_colour
      "\e[48;2;49m\e[38;2;39m"
    end

    def colour_index
      char_list.index(char_list[@iteration/@character_resolution]) || 8
    end

    def character_for_iteration
      return " " if @iteration == @dwell
      char_list[@iteration/@character_resolution] || "."
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
      (@window[1][0]-@window[0][0])/@resolution[0]
    end

    def y_increment
      (@window[1][1]-@window[0][1])/@resolution[1]
    end

    def column
      (@window[0][1]).step(@window[1][1],y_increment).to_a
    end

    def row
      (@window[0][0]).step(@window[1][0],x_increment).to_a
    end

  end

end
