require_relative 'window'
require_relative 'printer'
require_relative 'cartridges'

module Mandelruby
  class Set
    attr_reader :window, :printer
    def initialize(color = false)
      cartridge = color ? Color.new : Black.new
      @printer = Printer.new(cartridge)
      @window = Window.new
    end

    def to_s
      window.rows.map { |pixel_row|
        pixel_row.map { |pixel| printer.print_pixel(pixel) }.join("")
      }.join("\n")
    end
  end
end
