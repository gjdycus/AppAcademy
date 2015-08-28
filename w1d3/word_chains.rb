require 'byebug'

class WordChainer
  require 'set'
  attr_reader :dictionary
  attr_accessor :current_words, :all_seen_words

  def initialize(dictionary_file_name)
    @dictionary = Set.new(File.readlines(dictionary_file_name).map(&:chomp))
  end

  def adjacent_words(word)
    sub_dicionary = same_length_words(word)
    sub_dicionary.select {|el| one_off?(word, el)}
  end

  def same_length_words(word)
    dictionary.select { |el| word.length == el.length }
  end

  def one_off?(word1, word2)
    differences = 0
    word1.length.times do |i|
      differences += 1 if word1[i] != word2[i]
    end
    differences == 1 ? true : false
  end

  def run(source, target)
    current_words = [source]
    all_seen_words = [source]

    until current_words.empty? || current_words.include?(target)
      new_current_words = []
      current_words.each do |word|
        new_words = adjacent_words(word).select { |el| !all_seen_words.include?(el) }
        new_current_words += new_words
        all_seen_words += new_words
      end
      p new_current_words
      current_words = new_current_words
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  game = WordChainer.new("dictionary.txt")
  game.run("test", "ruby")
end
