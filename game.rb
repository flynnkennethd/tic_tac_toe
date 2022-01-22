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
    puts win_message(winner) if winner
    puts tie_message unless winner
  end
end