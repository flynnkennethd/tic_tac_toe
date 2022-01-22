class Player
  attr_reader :symbol, :name, :player_num
  attr_accessor :owned_tiles

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
    @owned_tiles = []
  end
end
