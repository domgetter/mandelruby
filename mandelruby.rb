#Mandelbrot Set graphical generator
require 'pry'
require_relative 'mandelruby/set'
color = ARGV.include?("--color")

#example to draw set with defaults (monochrome)
puts Mandelruby::Set.new().draw

# set drawn centered at (-1.5, 0), zoomed in 4x, with iteration limit of 150
# it will display in color if --color flag is set
options = {center: [-1.5,0], zoom: 2, dwell: 150, color: color}
puts Mandelruby::Set.new(options).draw
