#Mandelbrot Set graphical generator
require_relative 'mandelruby/set'

set = Mandelruby::Set.new.init
puts set.draw

puts Mandelruby::Set.new.draw_2