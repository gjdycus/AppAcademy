class Player

  attr_reader :name

  def initialize(name = "Bob")
    @name = name
  end

  def make_guess
    puts "Make your move, #{name}! x, y (type 'f' before the guess to flag or unflag)"

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
end
