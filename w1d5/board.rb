require_relative 'tile.rb'
require 'byebug'
require 'colorize'

class Board
  attr_accessor :grid

  ADJACENTS = [[0, 1], [0, -1], [1, 0], [-1, 0],
               [1, 1], [1, -1], [-1, 1], [-1, -1]
               ]

  NUMBER_COLORS = { 1 => :blue,
                    2 => :green,
                    3 => :red,
                    4 => :yellow,
                    5 => :cyan,
                    6 => :magenta,
                    7 => :light_blue,
                    8 => :light_green
                    }

  def initialize(bomb_count = 15)
    @grid = Array.new(9) {Array.new(9)}
    add_tiles
    create_neighbors
    add_bombs(bomb_count)
  end

  def display
    grid.each do |row|
      puts row.map {|tile| render_tile(tile) }.join(" ")
    end
  end

  def reveal_all
    grid.each { |row| row.each { |tile| tile.reveal } }
  end


  def render_tile(tile)
    return "F" if tile.flagged?

    case tile.revealed?
    when false
      return "*".colorize(:light_black)
    when true
      if tile.bomb?
        "x".colorize(:light_white)
      elsif tile.bomb_count == 0
        "_"
      else
        bomb_no = tile.bomb_count
        bomb_no.to_s.colorize(NUMBER_COLORS[bomb_no])
      end
    end
  end

  def add_tiles
    (0...grid.size).each do |i|
      (0...grid.size).each do |j|
        grid[i][j] = Tile.new
      end
    end
  end

  def create_neighbors
    grid.each do |row|
      row.each {|tile| tile.find_neighbors(self)}
    end
  end

  def get_neighbors(pos)
    candidates = ADJACENTS.map {|el| [el[0] + pos[0], el[1] + pos[1]]}
    candidates = candidates.select {|coord| in_bounds?(coord)}
    candidates.map { |coord| grid[coord[0]][coord[1]] }
  end

  def add_bombs(num_of_mines)
    positions.sample(num_of_mines).each do |pos|
      x, y = pos
      grid[x][y].value = :x
    end
  end


  def positions
    positions = []
    grid.size.times do |i|
      grid[0].size.times do |j|
        positions << [i,j]
      end
    end
    positions
  end

  def [](x,y)
    grid[x][y]
  end




  def in_bounds?(pos)
    x,y = pos
    (0...grid.size).include?(x) && (0...grid[0].size).include?(y)
  end

end
