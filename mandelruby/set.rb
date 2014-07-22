require_relative 'window'
require_relative 'printer'
require_relative 'cartridges'

module Mandelruby
  class Set
    def initialize(color = false)
      @window = Window.new
      cartridge = color ? Color.new : Black.new
      @mandelbrot = Printer.new(cartridge)
    end

    def to_s
      @window.rows.map { |pixel_row|
        pixel_row.map { |pixel| pixel.to_mandelbrot(@mandelbrot) }.join("")
      }.join("\n")
    end
  end
end
