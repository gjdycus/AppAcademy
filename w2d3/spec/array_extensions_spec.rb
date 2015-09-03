require 'rspec'
require 'array_extensions'

describe Array do
  describe "#my_uniq" do
    it "removes duplicates from passed array" do
      expect([1,3,1,2,2,3,1].my_uniq).to eq([1,3,1,2,2,3,1].uniq)
    end

    it "takes an empty array" do
      expect([].my_uniq).to eq([])
    end
  end

  describe "#two_sum" do
    it "return two elements that add to zero" do
      expect([-1,0,2,-2,1].two_sum).to eq([[0,4],[2,3]])
    end
  end

  describe "#my_transpose" do
    it "switches row and col values with each other" do
      expect([[1,2,3],[4,5,6]].my_transpose).to eq([[1,4],[2,5],[3,6]])
    end
  end

  describe "#stock_picker" do
    it "returns indices of the best times to buy and sell a stock" do
      expect([18,7,9,15,12,13,19].stock_picker).to eq([1,6])
    end

    it "doesn't sell before it buys" do
      expect([20,7,16,12,6].stock_picker[0]).to be < [20,7,16,12,6].stock_picker[1]
    end
  end
end
