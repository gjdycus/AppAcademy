class Board
  # attr_accessor :grid
  BOARD_SIZE = 4

  def initialize
    @grid = Array.new(BOARD_SIZE) { Array.new(BOARD_SIZE) }
    self.populate
  end

  def populate
    card_array = []
    until card_array.length == (BOARD_SIZE ** 2)
      temp_card = Card.new
      unless card_array.include?(temp_card)
        card_array << temp_card.dup
        card_array << temp_card
      end
    end

    puts "#{card_array}"
    card_array.shuffle!

    @grid.length.times do |i|
      @grid.length.times do |j|
        @grid[i][j] = card_array.pop
      end
    end
  end

  def render
    puts "----------------"
    @grid.length.times do |idx1|
      @grid.length.times do |idx2|
        print @grid[idx1][idx2]
      end
        print "\n"
    end
  end

  def reveal(guessed_pos)
    self[*guessed_pos].reveal
    self[*guessed_pos].value
  end

  def won?
    @grid.each do |sub_arr|
      return false if sub_arr.any? { |el| el.state == false }
    end
    true
  end

  def [](row, col)
    @grid[row][col]
  end

  private
    attr_reader :grid
end
