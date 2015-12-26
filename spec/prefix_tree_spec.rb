require "spec_helper"
require "prefix_tree"

RSpec.describe PrefixTree do
  let(:tree) { PrefixTree.new }
  before(:each) do
    tree << "soft".chars
    tree << "soften".chars
  end

  describe "#<<" do
    it "adds an entry to the tree" do
      tree << "hello".chars
      expect(tree).to include("hello".chars)
    end
  end

  describe "#include?" do
    it "is true for entries in the tree" do
      expect(tree).to include("soft".chars)
      expect(tree).to include("soften".chars)
    end

    it "is false for missing entries" do
      expect(tree).not_to include("softe".chars)
      expect(tree).not_to include("often".chars)
    end
  end

  describe "#prefix?" do
    it "is true for partial prefix matches" do
      expect(tree).to have_prefix("softe".chars)
    end

    it "is true for exact matches" do
      expect(tree).to have_prefix("soften".chars)
    end

    it "is false for non-matches" do
      expect(tree).not_to have_prefix("softener".chars)
      expect(tree).not_to have_prefix("often".chars)
    end
  end
end
