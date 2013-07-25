require './lib/sinatra_ttt'

class Sinatra_UI
  
#   helpers Sinatra::Cookies
  
  def get_opponent
    cookies[:opponent]
  end
  
  def get_board_width
    cookies[:board_width]
  end
  
  def get_square_to_mark
    params[:square]
  end
end
