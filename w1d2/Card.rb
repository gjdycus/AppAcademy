class Card
  attr_reader :value, :state
  VALUES = [
    "two",
    "three",
    "four",
    "five",
    "six",
    "seven",
    "eight",
    "nine",
    "ten",
    "jack",
    "queen",
    "king",
    "ace"
  ]

  def initialize
    @value = VALUES.sample
    @state = false
  end

  def hide
    @state = false
  end

  def reveal
    @state = true
  end

  def to_s
    if state
      pad(@value.to_s)
    else
      pad('x')
    end
  end

  def ==(card)
    value == card.value
  end

  private
    def pad(string)
      until string.length == 6
        string += " "
      end
      string
    end
end
