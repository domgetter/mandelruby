module Mandelruby

  class Set
  
    def initialize
      @output = ""
      @dwell = 200
      #resolution of characters in output
      @resolution = [80.0,40.0]
      # display window from top-left corner to bottom-right corner of complex plane
      @window = [[-2.0, 1.0], [0.5, -1.0]]
      #how many iterations before output uses a different character for bail levels
      @character_resolution = 2
    end
    
    def draw
      x_res = (@window[1][0]-@window[0][0])/@resolution[0]
      y_res = (@window[1][1]-@window[0][1])/@resolution[1]
      (@window[0][1]).step(@window[1][1],y_res) do |y|
        (@window[0][0]).step(@window[1][0],x_res) do |x|
          @output += mandelbrot(Complex(x,y))
        end
        @output += "\n"
      end
      @output
    end
    
    private
    
    def char_for(iteration)
      if (iteration-1)/@character_resolution > 7
        char_list[8]
      else
        char_list[(iteration-1)/@character_resolution]
      end
    end

    def mandelbrot(c)
      z = 0
      iteration = 0
      @dwell.times { z = z*z + c; iteration += 1; break if (z.abs >= 2)}
      iteration == @dwell ? " " : char_for(iteration)
    end
    
    def char_list
      @char_list ||= ["X","O","#","*","o","%","=","-",".","X"]
    end
    
  end

end
