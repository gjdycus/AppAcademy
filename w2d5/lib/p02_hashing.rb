class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    prime_nums = primes(self.length)
    hash = 0
    self.each_with_index do |el, index|
      hash = (el.hash ** prime_nums[index]).hash ^ hash
    end
    hash
  end
end

def is_prime?(num)
  (2...num).none? { |i| num % i == 0 }
end

def primes(count)
  primes = []
  i = 2
  until primes.count >= count
    primes << i if is_prime?(i)
    i += 1
  end
  primes
end

class String
  def hash
    self.chars.map(&:ord).hash
  end
end

class Hash
  def hash
    self.map { |h, k| [h, k] }.sort.hash
  end
end
