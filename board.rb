class Board
  attr_accessor :tiles
  ROW_DIVIDER = '--+---+--'
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9], 
  [1, 4, 7], [2, 5, 8], [3, 6, 9], 
  [1, 5, 9], [3, 5, 7]]
  
  def initialize
    @tiles = {1 => 1, 2 => 2, 3 => 3, 4 => 4,
      5 => 5, 6 => 6, 7 => 7, 8 => 8, 9 => 9,}
  end
  
  def print_board
    puts "#{self.tiles[1]} | #{self.tiles[2]} | #{self.tiles[3]}"
    puts ROW_DIVIDER
    puts "#{self.tiles[4]} | #{self.tiles[5]} | #{self.tiles[6]}"
    puts ROW_DIVIDER
    puts "#{self.tiles[7]} | #{self.tiles[8]} | #{self.tiles[9]}"
  end

  def update_board(tile, symbol)
    self.tiles[tile] = symbol
  end

  def valid_move?(tile)
    tiles[tile].is_a? Integer
  end
  def check_win(game)
    if WINNING_LINES.any? {|line| (line - game.player_1.owned_tiles).empty?}
      winner = game.player_1
      game.end_game(winner)
    end
    if WINNING_LINES.any? {|line| (line - game.player_2.owned_tiles).empty?}
      winner = game.player_2
      game.end_game(winner)
    end
  end
end
