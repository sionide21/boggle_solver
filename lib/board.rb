class Board
  NEIGHBORS = [[0, 1], [0, -1], [1, 0], [1, -1], [-1, 0], [-1, 1], [1, 1], [-1, -1]]

  def initialize(matrix)
    @matrix = matrix.map { |row| row.map { |value| Square.new(value) } }

    @matrix.each_with_index do |row, y|
      row.each_with_index do |square, x|
        neighboring_indices(y, x) do |i, j|
          square << self[i, j]
        end
      end
    end
  end

  def traverse(&blk)
    @matrix.flatten.each do |square|
      square.traverse([], &blk)
    end
  end

  def to_s
    @matrix.map { |line| line.join(" ") }.join("\n")
  end

  private

  def [](y, x)
    @matrix[y] && @matrix[y][x]
  end

  def neighboring_indices(i, j)
    indices = NEIGHBORS.map {|y, x| [y+i, x+j] }
    indices.each do |y, x|
      yield(y, x) unless y < 0 || x < 0
    end
  end

  class Square
    attr_reader :value

    def initialize(value)
      @value = value
      @neighbors = []
    end

    def traverse(current_path, &blk)
      return if current_path.include?(self)
      new_path = current_path + [self]
      return unless blk.call(new_path.map(&:value))
      @neighbors.each do |s|
        s.traverse(new_path, &blk)
      end
    end

    def <<(square)
      return unless square
      @neighbors << square
      @neighbors.sort_by!(&:value)
    end

    def to_s
      @value.to_s
    end
  end
end
