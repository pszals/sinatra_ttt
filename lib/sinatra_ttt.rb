require 'sinatra'
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
    selected_square = "square_#{params[:square]}"
    if cookies[selected_square] == ''
      response.set_cookie(selected_square, cookies[:marker])
      response.set_cookie('marker', opposite_marker)
      response.set_cookie('turn_incrementer', (cookies['turn_incrementer'].to_i + 1))
      erb :game
    else
      erb :game    
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
    
    (1..9).each {|n| response.set_cookie("square_#{n}", {:value => ''})}

    erb :game
  end
    
  get '/restart' do
    erb :welcome
  end
  
  def opposite_marker
    if cookies[:marker] == 'X'
      'O'
    else
      'X'
    end
  end
end