class Array
  def my_each(&blk)
    index = 0
    while index < self.length
      blk.call(self[index])
      index += 1
    end
    self
  end

  def my_select(&blk)
    selected = []
    self.my_each { |el| selected << el if blk.call(el) }
    selected
  end

  def my_reject(&blk)
    self - self.my_select(&blk)
  end

  def my_any?(&blk)
    self.my_select(&blk).length > 0
  end

  def my_all?(&blk)
    self.my_select(&blk).length == self.length
  end

  def my_flatten
    flattened = []
    self.my_each do |el|
      if el.class == Array
        flattened += el.my_flatten
      else
        flattened << el
      end
    end
    flattened
  end

  def my_zip(*args)
    zipped = []
    (0...self.length).to_a.my_each do |i|
      subarray = [self[i]]
      args.my_each { |arg| subarray << arg[i] }
      zipped << subarray
    end
    zipped
  end

  def my_rotate(offset = 1)
    offset = self.length + offset # if offset < 0
    offset.times do
      self << self.shift
    end
    self
  end

  def my_join(separator = "")
    separated_string = ""
    self.my_each do |el|
      separated_string << el + separator
    end
    separator.length > 0 ? separated_string[0...-separator.length] : separated_string
  end

  def my_reverse
    reversed = []
    (1..self.length).to_a.my_each do |index|
      reversed << self[-index]
    end
    reversed
  end
end
