class Board
  NEIGHBORS = [[-1,-1], [0,-1], [1,-1],
               [-1,0], [1, 0],
               [-1,1], [0,1], [1,1]]

  def self.transform(board)
    raise ArgumentError unless valid_board?(board)

    @board = prepare(board)
    update_board_size
    calculate_adjacent_bombs
    show
  end

  def self.show
    @board.map do |row|
      row.join
    end
  end

  private

  def self.prepare(board)
    board
      .map do |row|
        row.split //
      end
  end

  def self.update_board_size
    @rows = @board.size
    @columns = @board.first.size
    # puts "Field has #{@rows} rows and #{@columns} columns" # debugging
  end

  def self.calculate_adjacent_bombs
    @board.each_with_index do |row, row_index|
      next if row.first == '+'

      row.each_with_index do |tile, col_index|
        # puts "examining tile[#{row_index},#{col_index}] #{tile}" # debugging
        next if %w[* |].include? tile

        amount = NEIGHBORS.select do |neighbor|
          next unless valid_position?([row_index+neighbor[0], col_index+neighbor[1]])
          field = @board[row_index+neighbor[0]][col_index+neighbor[1]]
          # puts "neighbor [#{row_index+neighbor[0]},#{col_index+neighbor[1]}]: #{field}" # debugging
          field == '*'
        end.size
        # puts "Amount of bombs found around position[#{row_index},#{col_index}]: #{amount}" # debugging
        @board[row_index][col_index] = amount unless amount.zero?
      end
    end
  end

  def self.valid_board?(board)
    true
  end

  def self.valid_position?(pos)
    (pos[0] >= 0 &&
      pos[0] < @rows &&
      pos[1] >= 0 &&
      pos[1] < @columns)
  end
end
