require 'sinatra'
require './lib/sinatra_ui'
require 'ttt'

class SinatraTTT < Sinatra::Base
  get '/' do
    erb :welcome
  end

  get '/config' do
    erb :configure
  end  
  
  post '/config' do
    TTT.configure_game(params[:marker], params[:opponent], params[:board_size])
  end
  
  post '/make_move' do
    TTT.make_move(params[:square], params[:marker])
  end

  get '/output_board' do
    TTT.output_board(params[:board])
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