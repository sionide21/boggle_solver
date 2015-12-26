require "spec_helper"
require "board"

RSpec.describe Board do
  let(:board) {
    Board.new([[1, 2],
               [3, 4]])
  }

  it "can be created from a matrix" do
    expect(board.to_s).to eq("1 2\n3 4")
  end

  describe "#traverse" do
    def collect(board, &blk)
      blk ||= ->(path) { true }
      paths = []
      board.traverse do |path|
        paths << path
        blk.call(path)
      end
      paths
    end

    it "enumerates all paths on the board" do
      expect(collect(board)).to eq([
        [1], [1, 2], [1, 2, 3], [1, 2, 3, 4], [1, 2, 4], [1, 2, 4, 3],
        [1, 3], [1, 3, 2], [1, 3, 2, 4], [1, 3, 4], [1, 3, 4, 2],
        [1, 4], [1, 4, 2], [1, 4, 2, 3], [1, 4, 3], [1, 4, 3, 2],
        [2], [2, 1], [2, 1, 3], [2, 1, 3, 4], [2, 1, 4], [2, 1, 4, 3],
        [2, 3], [2, 3, 1], [2, 3, 1, 4], [2, 3, 4], [2, 3, 4, 1],
        [2, 4], [2, 4, 1], [2, 4, 1, 3], [2, 4, 3], [2, 4, 3, 1],
        [3], [3, 1], [3, 1, 2], [3, 1, 2, 4], [3, 1, 4], [3, 1, 4, 2],
        [3, 2], [3, 2, 1], [3, 2, 1, 4], [3, 2, 4], [3, 2, 4, 1],
        [3, 4], [3, 4, 1], [3, 4, 1, 2], [3, 4, 2], [3, 4, 2, 1],
        [4], [4, 1], [4, 1, 2], [4, 1, 2, 3], [4, 1, 3], [4, 1, 3, 2],
        [4, 2], [4, 2, 1], [4, 2, 1, 3], [4, 2, 3], [4, 2, 3, 1], [4, 3],
        [4, 3, 1], [4, 3, 1, 2], [4, 3, 2], [4, 3, 2, 1]
      ])
    end

    it "only walks to immediate neighbors" do
      board = Board.new([[1, 2, 3],
                         [4, 5]])
      paths = collect(board)
      expect(paths).to include([1, 2, 3])
      expect(paths).not_to include([1, 3])
    end

    it "stops searching a path if the yielded block returns false" do
      paths = collect(board) do |path|
        path.length == 0
      end

      expect(paths).to eq([[1], [2], [3], [4]])
    end
  end
end
