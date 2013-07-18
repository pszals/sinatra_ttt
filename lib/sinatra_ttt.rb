require 'sinatra'
require './lib/sinatra_ui'
require './lib/ttt'

class Sinatra_TTT < Sinatra::Base
  get '/' do
    erb :welcome
  end

  get '/config' do
    erb :configure
  end  
  
  post '/config' do
#     Sinatra_UI.configure_game(params[:marker], params[:opponent], params[:board_size])
  end
  
  post '/make_move' do
    response.set_cookie('marker',     {:value => params[:marker],     :path => '/make_move'})
    response.set_cookie('opponent',   {:value => params[:opponent],   :path => '/make_move'})
    response.set_cookie('board_size', {:value => params[:board_size], :path => '/make_move'})
#     Sinatra_TTT.make_move(params[:square], params[:marker])
  end

  get '/output_board' do
    TTT.output_board(params[:board])
  end
  
  get '/game' do
    erb :game
  end  

  post '/game' do
     SinatraUI.print_board(' 1 | 2 | 3 ') 
  end
  
  get '/restart' do
    erb :welcome
  end
  
  post '/restart' do
    TTT.restart(params[:restart_choice])
  end
end