#Mandlebrot Set graphical generator
#At first, the dwell of 200 and a resolution of 80x80 with "X"s to signify pixels in the console

# map the square region [0,79] x [0,79] to the region {Z e C : -2 <= Re(Z) <= 2, -2 <= Im(Z) <= 2}
# so that at each x and y value, you set C to that value inside the deepest part of the double loop
# when each inner loop begins, set Z to 0 + 0i
# and create a 3rd loop inside that double loop
# make a variable its
# it's an int
# it starts at 0 and goes to, say, 200
# at each iteration of the loop, you set Z_new to Z^2 + C
# then set Z to Z_new
# if |Z| >= 2, break the loop
# and print an "X" character to the stdout
# if the loop never breaks, print an "O" character to stdout instead

# Z_next = Z_curr^2 + C

module Mandleruby

  class Set
  
    
    
  end

end
print "\tWelcome to this po-dunk version of a Mandlebrot Set visualizer!\n"
print "\t                   written by Dominic Muller\n\n"
print "\tWhat mode would you like? (d = default, a = advanced): "
input = gets.chomp

unless input.upcase == "A" || input.upcase == "D"
  loop do
    print "\n"
    print "\tPlease use a valid input\n"
    print "\tWhat mode would you like? (d = default, a = advanced): "
    input = gets.chomp
    break if input.upcase == "A" || input.upcase == "D"
  end
end


def draw(input)

  char_list = ["X","O","#","*","o","%","=","-","."]
  #number of iterations before bailing
  dwell = 200
  #resolution of characters in output
  resolution = [80,80]
  #how many iterations before output uses a different character for bail levels
  character_resolution = 2
  #which calculation method is used
  calc_type = 0
  output = ""

  if input.upcase == "A"
    print "\tResolution (default is 80x80)\n"
    print "\t  Please input a horizontal resolution: "
    resolution_input_x = gets.chomp
    print "\t  Please input a vertical resolution: "
    resolution_input_y = gets.chomp
    resolution = [resolution_input_x.to_i,resolution_input_y.to_i]
    print "\tIterations (default is 200)\n"
    print "\t  Please input a maximum interation: "
    dwell_input = gets.chomp
    dwell = dwell_input.to_i
    print "\tCharacter Resolution (default is 2)\n"
    print "\t  Please input a character resolution: "
    character_resolution_input = gets.chomp
    character_resolution = character_resolution_input.to_i
    print "\tCalculation type (default is (C)Complex Object. Other option is (A)lternative)\n"
    print "\t  Please input a calculation type: "
    calc_type_input = gets.chomp.upcase
    if calc_type_input == "C"
      calc_type = 0
    else
      calc_type = 1
    end
  end

  if calc_type == 0
    (1..resolution[1]).each do |j|
      (1..resolution[0]).each do |i|
        z_curr = Complex(0)
        (1..dwell).each do |iteration|
          c = Complex((i-resolution[0]/2.0)/(resolution[0]/4.0),(j-resolution[1]/2.0)/(resolution[1]/4.0))
          z_next = z_curr**2 + c
          if z_next.abs >= 2.0
            case iteration
            when (1..character_resolution)
              output += char_list[0]
            when ((character_resolution+1)..(character_resolution*2))
              output += char_list[1]
            when ((character_resolution*2+1)..(character_resolution*3))
              output += char_list[2]
            when ((character_resolution*3+1)..(character_resolution*4))
              output += char_list[3]
            when ((character_resolution*4+1)..(character_resolution*5))
              output += char_list[4]
            when ((character_resolution*5+1)..(character_resolution*6))
              output += char_list[5]
            when ((character_resolution*6+1)..(character_resolution*7))
              output += char_list[6]
            when ((character_resolution*7+1)..(character_resolution*8))
              output += char_list[7]
            else
              output += char_list[8]
            end
            break
          end
          if iteration==dwell
            output += " "
            break
          end
          z_curr = z_next
        end      
      end
      output += "\n"
    end
  elsif calc_type == 1
    resolution_y = resolution[1]
    resolution_x = resolution[0]
    (1..resolution_y).each do |j|
      (1..resolution_x).each do |i|
        #(-40,40)..(40,40)
        #(-2,2)..(2,2)
        z_curr_a = 0
        z_curr_b = 0
        #puts Complex((i-resolution[0]/2.0)/(resolution[0]/4.0),(j-resolution[1]/2.0)/(resolution[1]/4.0))
        (1..dwell).each do |iteration|
          #c = Complex((i-resolution[0]/2.0)/(resolution[0]/4.0),(j-resolution[1]/2.0)/(resolution[1]/4.0))
          c_a = (i-resolution_x/2.0)/(resolution_x/4.0)
          c_b = (j-resolution_y/2.0)/(resolution_y/4.0)
          z_curr_squared_a = z_curr_a**2 - z_curr_b**2
          z_curr_squared_b = 2*z_curr_a*z_curr_b
          z_next_a = z_curr_squared_a + c_a
          z_next_b = z_curr_squared_b + c_b
          if z_next_a**2+z_next_b**2 >= 4.0
            case iteration
            when (1..character_resolution)
              output += char_list[0]
            when ((character_resolution+1)..(character_resolution*2))
              output += char_list[1]
            when ((character_resolution*2+1)..(character_resolution*3))
              output += char_list[2]
            when ((character_resolution*3+1)..(character_resolution*4))
              output += char_list[3]
            when ((character_resolution*4+1)..(character_resolution*5))
              output += char_list[4]
            when ((character_resolution*5+1)..(character_resolution*6))
              output += char_list[5]
            when ((character_resolution*6+1)..(character_resolution*7))
              output += char_list[6]
            when ((character_resolution*7+1)..(character_resolution*8))
              output += char_list[7]
            else
              output += char_list[8]
            end
            break
          end
          if iteration==dwell
            output += " "
            break
          end
          z_curr_a = z_next_a
          z_curr_b = z_next_b
        end      
      end
      output += "\n"
    end
  end
  output

end


puts draw input