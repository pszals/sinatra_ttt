require './lib/sinatra_ttt'

class Sinatra_UI
  def get_opponent
    cookies[:opponent]
  end
  
  def get_board_width
    cookies[:board_width]
  end
  
#   def self.configure_game(marker, opponent, board_size)
#     ttt.configure
#   end
end