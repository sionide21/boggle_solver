class Board
  def initialize(matrix)
    @matrix = matrix.map { |row| row.map { |value| Square.new(value) } }

    @matrix.each_with_index do |row, y|
      row.each_with_index do |square, x|
        neighboring_squares(y, x) do |i, j|
          next if i < 0 || j < 0
          square << @matrix[i][j] if @matrix[i]
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

  def neighboring_squares(i, j)
    yield(i, j-1)
    yield(i, j+1)
    yield(i-1, j)
    yield(i-1, j-1)
    yield(i-1, j+1)
    yield(i+1, j)
    yield(i+1, j-1)
    yield(i+1, j+1)
  end

  class Square
    attr_reader :value, :neighbors

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
