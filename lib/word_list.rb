require "prefix_tree"

class WordList
  def self.load(filename)
    new(File.read(filename).lines.map(&:strip))
  end

  attr_reader :words
  def initialize(words)
    @words = words.map(&:downcase).uniq
  end

  def to_prefix_tree
    @prefix_tree ||= build_tree
  end

  def inspect
    "#<WordList length=#{words.length}>"
  end

  private

  def build_tree
    PrefixTree.new.tap do |tree|
      words.each do |word|
        tree << word.chars
      end
    end
  end
end
