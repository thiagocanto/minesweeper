require_relative 'lib/board'

class MinesweeperExhibitor
  def initialize(board)
    @board = Board.new(board)
  end

  def format
    @board.show
  end
end

board = " * * 
  *  
  *  
     "

minesweeper = MinesweeperExhibitor.new(board)
minesweeper.format
