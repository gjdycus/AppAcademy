class Player

  attr_reader :name

  def initialize
    @name = get_name
  end

  def make_guess
    puts "Make your move, #{name}! (row, column) *type 'f' before your guess to flag or unflag*"
    puts "Type \"save\" to save game state for later."

    guess = gets.chomp.downcase
    return guess if guess == "save"

    action = :reveal

    if guess.include?("f")
      action = :flag
      guess.slice!(0)
    end
    pos = guess.split(",").map { |num| num.to_i }
    return [action, pos]
  end

  def get_name
    system("clear")
    puts "What is your name?"
    name = gets.chomp
    until name.length >= 1
      puts "Please enter a name."
      name = gets.chomp
    end
    name
  end
end
