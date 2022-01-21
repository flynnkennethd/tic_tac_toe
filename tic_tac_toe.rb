
class Game
  include Messages
  attr_reader :player_1, :player_2
  def initialize
    @board = Board.New
    @is_player_1_turn? = true
  end

  def create_players
    puts create_player_prompt(1)
    player_1_name = gets.chomp
    @player_1 = Player.new(player_1_name, 'X')
    puts create_player_prompt(2)
    player_2_name = gets.chomp
    @player_2 = Player.new(player_2_name, 'O')
  end

  def change_turn
    @is_player_1_turn? = !@is_player_1_turn?
  end

  def take_turn(is_player_1_turn?)
    current_player = is_player_1_turn? ? player_1 : player_2
    puts turn_prompt
    tile_choice = gets.chomp.to_int
    if tile_choice.class != Integer
      puts invalid_input
      take_turn
    elsif !@board.valid_move?(tile_choice)
      puts invalid_input
      take_turn
    else
      @board.update_board(tile_choice, current_player.symbol)
      current_player.owned_tiles += tile_choice
    end
    board.print_board
    board.check_win
    change_turn
  end
  def end_game(winner)
    puts win_message(winner.name)
  end
end

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
  def check_win
    WINNING_LINES.each do |line|
      (game.player_1.owned_tiles - line).empty?
    end
    WINNING_LINES.each do |line|
      (game.player_2.owned_tiles - line).empty?
    end
    game.end_game(winner)
end


class Player
  attr_reader :symbol
  attr_accessor :owned_tiles

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
    @owned_tiles = []
  end

end
