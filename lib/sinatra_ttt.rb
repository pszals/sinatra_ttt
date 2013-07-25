require 'sinatra'
require './lib/sinatra_ui'
require 'sinatra/cookies'

class Sinatra_TTT < Sinatra::Base
  
  helpers Sinatra::Cookies
 
  attr_reader :params
  
  get '/' do
    erb :welcome
  end

  get '/config' do
    erb :configure
  end  
    
  post '/make_move' do
    if cookies["square_#{params[:square]}"] == ''
      response.set_cookie("square_#{params[:square]}", cookies[:marker])
      response.set_cookie('marker', opposite_marker)
      response.set_cookie('turn_incrementer', (cookies['turn_incrementer'].to_i + 1))
      erb :game
    else
      erb :game    
    end
  end
  
  def opposite_marker
    if cookies[:marker] == 'X'
      'O'
    else
      'X'
    end
  end
  
  get '/game' do
    erb :game
  end  

  post '/game' do
    response.set_cookie('marker',           {:value => params[:marker],     :path => '/'})
    response.set_cookie('opponent',         {:value => params[:opponent],   :path => '/game'})
    response.set_cookie('board_size',       {:value => params[:board_size], :path => '/game'})
    response.set_cookie('turn_incrementer', {:value => 0})
    
    response.set_cookie('square_1', {:value => ''})
    response.set_cookie('square_2', {:value => ''})
    response.set_cookie('square_3', {:value => ''})
    response.set_cookie('square_4', {:value => ''})
    response.set_cookie('square_5', {:value => ''})
    response.set_cookie('square_6', {:value => ''})
    response.set_cookie('square_7', {:value => ''})
    response.set_cookie('square_8', {:value => ''})
    response.set_cookie('square_9', {:value => ''})
        
    erb :game
  end
    
  get '/restart' do
    erb :welcome
  end
end