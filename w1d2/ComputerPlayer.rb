require 'byebug'
class ComputerPlayer
  attr_reader :name, :known_cards
  attr_accessor :last_guess, :num_of_guesses, :known_matches, :matched_cards,
                :guesses

  def initialize
    @name = "Computer"
    @known_cards = {}
    @last_guess = nil
    @matched_cards = []
    @known_matches = []
    @num_of_guesses = 0
    @guesses = []

    0.upto(3) do |idx1|
      0.upto(3) do |idx2|
        guesses << [idx1,idx2]
      end
    end

  end

  def make_guess
    self.num_of_guesses += 1

    check_for_matches

    if !known_matches.empty?
      guess = self.known_matches.shift
      # guesses.delete_if {|el| el == guess}
    else
      # guess = [rand(4), rand(4)]
      guess = guesses.sample
      until intelligent_guess?(guess)
        # guess = [rand(4), rand(4)]
        guesses.delete_if {|el| el == guess}
        guess = guesses.sample
      end

      receive_match(guess, last_guess) if num_of_guesses.even?
    end
    self.last_guess = guess
    guess
  end

  def check_for_matches
    known_cards.each do |pos,value|
      if known_cards.values.count(value) == 2 && !matched_cards.include?(pos)

        self.known_matches += known_cards.keys.select do |key|
          known_cards[key] == value && !known_matches.include?(key) &&
          !matched_cards.include?(key)
        end
        receive_match(known_matches[-1], known_matches[-2])
        known_cards.delete(pos)
        # known_cards.delete(known_matches[-1])
        # known_cards.delete(known_matches[-2])
      end
    end
  end

  def intelligent_guess?(pos)
    !matched_cards.include?(pos)
  end

  def receive_revealed_card(card_value)
    known_cards[last_guess] = card_value
  end

  def receive_match(pos1, pos2)
    if known_cards[pos1] == known_cards[pos2] && pos1 != pos2
      self.matched_cards += [pos1, pos2]
      guesses.delete_if {|el| el == pos1 || el == pos2}
    end
  end
end
