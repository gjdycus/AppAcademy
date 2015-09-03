require 'rspec'
require 'card'

describe Card do
  subject(:card){Card.new(:hearts, :ace)}
  describe "#initialize" do
    it "defines a card suit and rank" do
      expect(card.suit).to eq(:hearts)
      expect(card.rank).to eq(:ace)
    end
  end

  describe "#to_s" do
    it "displays the card as a string" do
      expect(card.to_s).to eq("A♥")
    end
  end

end
