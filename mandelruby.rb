#Mandelbrot Set graphical generator
require_relative 'mandelruby/set'
color = ARGV.include?("--color")
puts Mandelruby::Set.new(color)
