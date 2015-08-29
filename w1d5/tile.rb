class Tile

  attr_accessor :value, :neighbors, :revealed, :flagged

  def initialize
    @value = nil
    @neighbors = nil
    @revealed = false
    @flagged = false
  end

  def revealed?
    @revealed
  end

  def reveal
    @revealed = true

    if bomb_count == 0 && !bomb?
      neighbors.each do |tile|
        tile.reveal unless tile.revealed?
      end
    end

    if flagged?
      @flagged = false
    end
    nil
  end

  def flagged?
    @flagged
  end

  def flag
    @flagged = !@flagged unless revealed?
    nil
  end

  def bomb?
    value == :x
  end

  def bomb_count
    count = 0
    neighbors.each do |neighb|
      count += 1 if neighb.value == :x
    end
    count
  end

  def find_neighbors(board)
    board.grid.each_with_index do |row, i|
      row.each_with_index do |tile, j|
        if tile == self
          @neighbors = board.get_neighbors([i, j])
        end
      end
    end
  end

end
