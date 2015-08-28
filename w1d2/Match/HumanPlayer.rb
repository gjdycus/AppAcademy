class HumanPlayer
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def make_guess
    puts "Choose a card"
    guess = gets.chomp.split(",").map(&:to_i)
  end

  def receive_revealed_card(_)
  end
end
