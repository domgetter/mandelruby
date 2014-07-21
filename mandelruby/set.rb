module Mandelruby

  class Set
  
    def initialize
      @char_list = ["X","O","#","*","o","%","=","-","."]
      @output = ""
      #resolution of characters in output
      @resolution = [80,80]
      #number of iterations before bailing
      @dwell = 200
      #how many iterations before output uses a different character for bail levels
      @character_resolution = 2
      #which calculation method is used
      @calc_type = 0
    end
  
    def init
    
      print "\tWelcome to this po-dunk version of a Mandelbrot Set visualizer!\n"
      print "\t                   written by Dominic Muller\n\n"
      print "\tWhat mode would you like? (d = default, a = advanced): "
      @input = gets.chomp

      unless @input.upcase == "A" || @input.upcase == "D"
        loop do
          print "\n"
          print "\tPlease use a valid input\n"
          print "\tWhat mode would you like? (d = default, a = advanced): "
          @input = gets.chomp
          break if @input.upcase == "A" || @input.upcase == "D"
        end
      end

      if @input.upcase == "A"
        print "\tResolution (default is 80x80)\n"
        print "\t  Please input a horizontal resolution: "
        resolution_input_x = gets.chomp
        print "\t  Please input a vertical resolution: "
        resolution_input_y = gets.chomp
        @resolution = [resolution_input_x.to_i,resolution_input_y.to_i]
        print "\tIterations (default is 200)\n"
        print "\t  Please input a maximum interation: "
        @dwell_input = gets.chomp
        @dwell = @dwell_input.to_i
        print "\tCharacter Resolution (default is 2)\n"
        print "\t  Please input a character resolution: "
        character_resolution_input = gets.chomp
        @character_resolution = character_resolution_input.to_i
        print "\tCalculation type (default is (C)Complex Object. Other option is (A)lternative)\n"
        print "\t  Please input a calculation type: "
        calc_type_input = gets.chomp.upcase
        if calc_type_input == "C"
          @calc_type = 0
        else
          @calc_type = 1
        end
      end
    
      self
    end
    
    def draw

      if @calc_type == 0
        (1..@resolution[1]).each do |j|
          (1..@resolution[0]).each do |i|
            z_curr = Complex(0)
            (1..@dwell).each do |iteration|
              c = Complex((i-@resolution[0]/2.0)/(@resolution[0]/4.0),(j-@resolution[1]/2.0)/(@resolution[1]/4.0))
              z_next = z_curr**2 + c
              if z_next.abs >= 2.0
                char_for iteration
                break
              end
              if iteration==@dwell
                @output += " "
                break
              end
              z_curr = z_next
            end      
          end
          @output += "\n"
        end
      elsif @calc_type == 1
        @resolution_y = @resolution[1]
        @resolution_x = @resolution[0]
        (1..@resolution_y).each do |j|
          (1..@resolution_x).each do |i|
            z_curr_a = 0
            z_curr_b = 0
            (1..@dwell).each do |iteration|
              c_a = (i-@resolution_x/2.0)/(@resolution_x/4.0)
              c_b = (j-@resolution_y/2.0)/(@resolution_y/4.0)
              z_curr_squared_a = z_curr_a**2 - z_curr_b**2
              z_curr_squared_b = 2*z_curr_a*z_curr_b
              z_next_a = z_curr_squared_a + c_a
              z_next_b = z_curr_squared_b + c_b
              if z_next_a**2+z_next_b**2 >= 4.0
                char_for iteration
                break
              end
              if iteration==@dwell
                @output += " "
                break
              end
              z_curr_a = z_next_a
              z_curr_b = z_next_b
            end      
          end
          @output += "\n"
        end
      end
      @output

    end
    
    def char_for(iteration)
    
      case iteration
      when (1..@character_resolution)
        @output += @char_list[0]
      when ((@character_resolution+1)..(@character_resolution*2))
        @output += @char_list[1]
      when ((@character_resolution*2+1)..(@character_resolution*3))
        @output += @char_list[2]
      when ((@character_resolution*3+1)..(@character_resolution*4))
        @output += @char_list[3]
      when ((@character_resolution*4+1)..(@character_resolution*5))
        @output += @char_list[4]
      when ((@character_resolution*5+1)..(@character_resolution*6))
        @output += @char_list[5]
      when ((@character_resolution*6+1)..(@character_resolution*7))
        @output += @char_list[6]
      when ((@character_resolution*7+1)..(@character_resolution*8))
        @output += @char_list[7]
      else
        @output += @char_list[8]
      end
    end
     
  # everything below here is from:
  # http://eigenjoy.com/2008/02/22/ruby-inject-and-the-mandelbrot-set/

    def mandelbrot(c)
      z = 0
      dwell = 50
      iterations = 0
      dwell.times { z = z*z + c; iterations += 1; break if z.abs > 2 }
      z
    end
    
    def draw_2
      output = ""
      domain = [-2, 0.5]
      range = [-1,1]
      x_res = (domain[1]-domain[0])/80.0
      y_res = (range[1]-range[0])/20.0
      (range[1]).step(range[0],y_res) do |y|
        (domain[1]).step(domain[0],x_res) do |x|
          output += mandelbrot(Complex(x,y)).abs < 2 ? ' ' : '*'
        end
        output += "\n"
      end
      output
    end
    
  end

end