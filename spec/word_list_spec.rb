require "spec_helper"
require "word_list"

RSpec.describe WordList do
  let(:wordlist) { WordList.new(["soft", "soften"]) }

  describe "#to_prefix_tree" do
    it "converts its words into a prefix tree" do
      tree = wordlist.to_prefix_tree
      expect(tree).to include("soften".chars)
      expect(tree).to include("soft".chars)
    end
  end

  describe "#words" do
    let(:wordlist) { WordList.new(["soften", "Soften", "SOFTEN", "OFTEN"]) }

    it "treats everything as lower case" do
      expect(wordlist.words).to eq(["soften", "often"])
    end
  end

  describe ".load" do
    it "reads a word list from a file" do
      expect(WordList.load("spec/fixtures/words.txt").words).to eq(["soft", "soften"])
    end
  end
end
