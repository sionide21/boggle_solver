require "spec_helper"
require "board"
require "boggle"
require "word_list"

RSpec.describe Boggle do
  let(:wordlist) { WordList.new(["free", "freed", "fret", "head", "row", "the"]) }
  let(:board) { Board.new([
    %w{ d e e t },
    %w{ o h r h },
    %w{ p f d p },
    %w{ r o w e }
  ]) }
  let(:boggle) { Boggle.new(board, wordlist) }

  describe "#solve" do
    it "finds words on the board from the provided list, longest first" do
      expect(boggle.solve).to eq([
        "freed",
        "free",
        "fret",
        "row",
        "the"
      ])
    end
  end
end
