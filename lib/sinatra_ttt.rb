$LOAD_PATH.unshift File.expand_path('../../../ruby_tictactoe/lib', __FILE__)

require 'sinatra'
require 'sinatra/cookies'
require './lib/sinatra_ui'
require 'new_game'
require 'bundler'
Bundler.require(:default)

class Sinatra_TTT < Sinatra::Base
  helpers Sinatra::Cookies
  
  attr_reader :params, :current_board
  
  get '/' do
    erb :welcome
  end

  get '/config' do
    erb :configure
  end  
  
  post '/make_move' do
    selected_square = "square_#{params[:square]}"
    if cookies[selected_square] != 'X' || cookies[selected_square] != 'O'
      response.set_cookie(selected_square, cookies[:marker])
      response.set_cookie('marker', opposite_marker)
      response.set_cookie('turn_incrementer', (cookies['turn_incrementer'].to_i + 1))
      gather_squares_from_cookies
      response.set_cookie('current_board', {:value => @current_board})
      run_game
      erb :game
    else
      erb :game    
    end
  end
  
  def run_game
    new_game = New_Game.new(Sinatra_UI.new, @current_board) 
    new_game.game_loop
  end

  def gather_squares_from_cookies
    @current_board = []
    (1..9).to_a.each do |n|
      @current_board << cookies["square_#{n}"] 
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
    setup_board

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

  def take_turn(best_move)
    if cookies[:turn_incrementer] % 2 == 0
      response.set_cookie("square_#{best_move}", {:value => params[:marker]})
    end
  end

  def display_winner(winner)
    response.set_cookie('winner', {:value => winner})
  end

  def display_tie
    response.set_cookie('winner', {:value => "Tie Game"})
  end

  def integer_board
    (1..params[:board_size]**2).to_a
  end

  def squares_to_string
    integer_board.map {|square| square.to_s}
  end

  def setup_board
    (1..9).each {|n| response.set_cookie("square_#{n}", {:value => "#{n}"})}
    @current_board = []
  end
end
