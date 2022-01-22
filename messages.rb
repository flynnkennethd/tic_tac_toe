module Messages
  def welcome_message
    "Welcome! This is a Tic-Tac-Toe program written by Kenneth Flynn. Please Enjoy!"
  end
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
  def play_again_message
    "Would you like to play again? Enter Y for yes or N for no"
  end
end
