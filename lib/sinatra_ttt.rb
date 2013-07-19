require 'sinatra'
require './lib/sinatra_ui'
# require 'TTT'


class Sinatra_TTT < Sinatra::Base  
  get '/' do
    erb :welcome
  end

  get '/config' do
    erb :configure
  end  
  
  post '/config' do
    Sinatra_UI.configure_game(params[:marker], params[:opponent], params[:board_size])
  end
  
  post '/make_move' do
#     response.set_cookie('square', {:value => params[:square_1], :path => '/game'})
    redirect '/game'
  end

  get '/output_board' do
#     TTT.output_board(params[:board])
  end
  
  get '/game' do
    erb :game
  end  

  post '/game' do
    response.set_cookie('marker',     {:value => params[:marker],     :path => '/game'})
    response.set_cookie('opponent',   {:value => params[:opponent],   :path => '/game'})
    response.set_cookie('board_size', {:value => params[:board_size], :path => '/game'})
    
#     configure_game
    erb :game
  end
  
  get '/restart' do
    erb :welcome
  end
  
  post '/restart' do
#     TTT.restart(params[:restart_choice])
  end
  
  def configure_game
    ui = Sinatra_UI.new
    @ai = Unbeatable_AI.new
    configure_opponent
    player_1 = Player.new('X')
    player_2 = Player.new('O')
    board = Board.new(player_1, player_2)
    board.width = cookies[:board_size]
    game = Game.new(board, ui, @ai, player_1, player_2)

  end
  
  def configure_opponent
    @ui.ask_for_opponent
    opponent_type = @ui.get_opponent
    if cookies[:opponent] == 'computer'
      @ai.opponent = true
    else
      @ai.opponent = false
    end
  end
  
#   def configure_player_1(marker)
#   
#   end
end