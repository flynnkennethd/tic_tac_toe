
class NewGame
  def initialize
    @board = Board.new
  end
end


class Board
  attr_accessor :row_1, :row_2, :row_3
  ROW_DIVIDER = '--+---+--'
  def initialize
    @row_1 = [1, 2, 3]
    @row_2 = [4, 5, 6]
    @row_3 = [7, 8, 9]
  end
  def print_board
    puts row_1.join(' | ')
    puts ROW_DIVIDER
    puts @row_2.join(' | ')
    puts ROW_DIVIDER
    puts @row_3.join(' | ')
  end
end


class Player
  def initialize(name)
    @name = name
  end
end
