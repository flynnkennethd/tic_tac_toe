module Messages
  def invalid_input
    "Invalid input, please try again."
  end
  def create_player_prompt(player_number)
    "Please enter the name to be used for player ##{player_number}."
  end

  def turn_prompt(player)
    "Please enter the tile number you'd like to take, #{player.name}."
  end

  def win_message(winner)
    "Congratulations, #{winner.name}, you've won the game!"
  end
  def tie_message
    "It's a tie!"
end

class Game
  include Messages
  attr_reader :player_1, :player_2, :board, :is_player_1_turn
  def initialize
    @board = Board.new
    @is_player_1_turn = true
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
    @is_player_1_turn = !@is_player_1_turn
  end

  def take_turn(is_player_1_turn)
    current_player = is_player_1_turn ? self.player_1 : self.player_2
    puts turn_prompt(current_player)
    tile_choice = Integer(gets) rescue nil
    if tile_choice.class != Integer
      puts invalid_input
      take_turn(self.is_player_1_turn)
    elsif !self.board.valid_move?(tile_choice)
      puts invalid_input
      take_turn(self.is_player_1_turn)
    else
      self.board.update_board(tile_choice, current_player.symbol)
      current_player.owned_tiles.append(tile_choice)
      board.print_board
      board.check_win(self)
      change_turn
    end
  end
  def end_game(winner = nil)
    puts win_message(winner.name) if winner
    puts tie_message unless winner
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


class Player
  attr_reader :symbol, :name, :player_num
  attr_accessor :owned_tiles

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
    @owned_tiles = []
  end
end
