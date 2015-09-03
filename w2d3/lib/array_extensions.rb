class Array
  def my_uniq
    results = []
    self.each do |num|
      results << num unless results.include?(num)
    end
    results
  end

  def two_sum
    results = []

    self.length.times do |idx1|
      (idx1+1...self.length).each do |idx2|
        if self[idx1] + self[idx2] == 0
          results << [idx1, idx2]
        end
      end
    end

    results
  end

  def my_transpose
    transpose = []

    self.first.length.times do |col|
      temp_row = []
      self.length.times do |row|
        temp_row << self[row][col]
      end
      transpose << temp_row
    end
    transpose
  end

  def stock_picker
    answer = [0,1]
    current_best = self[1]-self[0]
    self.length.times do |idx1|
      (idx1+1...self.length).each do |idx2|
        if self[idx2]-self[idx1] > current_best
          current_best = self[idx2]-self[idx1]
          answer = [idx1, idx2]
        end
      end
    end
    answer
  end

end
