require_relative 'pixel'

module Mandelruby
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
end
