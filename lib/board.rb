class Board
  NEIGHBORS = [[-1,-1], [0,-1], [1,-1],
               [-1,0], [1, 0],
               [-1,1], [0,1], [1,1]]

  def initialize(board)
    @board = prepare(board)
    update_board_size
    calculate_adjacent_bombs
  end

  def show
    @board.each_with_index do |row, index|
      print_row(row, index)
    end
  end

  private

  def prepare(board)
    board
      .split(/\n/)
      .map do |row|
        row.split //
      end
  end

  def update_board_size
    @rows = @board.size
    @columns = @board.first.size
    # puts "Field has #{@rows} rows and #{@columns} columns" # debugging
  end

  def calculate_adjacent_bombs
    @board.each_with_index do |row, row_index|
      row.each_with_index do |tile, col_index|
        # puts "examining tile[#{row_index},#{col_index}] #{tile}" # debugging
        next if tile == '*'

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

  def print_row(row, index)
    row.each {|tile| print "[#{tile}]"}
    puts
  end

  def valid_position?(pos)
    (pos[0] >= 0 &&
      pos[0] < @rows &&
      pos[1] >= 0 &&
      pos[1] < @columns)
  end
end
