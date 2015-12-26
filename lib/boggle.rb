class Boggle
  def initialize(board, wordlist)
    @board = board
    @wordlist = wordlist
  end

  def solve
    words = []
    @board.traverse do |path|
      words << path.join if prefix_tree.include?(path)
      prefix_tree.has_prefix?(path)
    end
    words.uniq.sort.sort_by(&:length).reverse
  end

  private

  def prefix_tree
    @prefix_tree ||= @wordlist.to_prefix_tree
  end
end
