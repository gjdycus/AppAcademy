require 'colorize'

class Tile
  attr_accessor :value, :given

  def initialize(value, given)
    @value = value.to_s
    @given = given
    @value.colorize(:blue) if @given
  end
end
