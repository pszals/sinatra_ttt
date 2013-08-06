$LOAD_PATH.unshift File.expand_path('../../../ruby_tictactoe/lib', __FILE__)

require 'sinatra'
require 'sinatra/cookies'
require './lib/sinatra_ui'
require 'web_game'
require 'bundler'
Bundler.require(:default)
Bundler.setup

class Sinatra_TTT < Sinatra::Base
  helpers Sinatra::Cookies
  
  attr_reader :params, :current_board, :web_game
  
  get '/' do
    clear_cookies
    erb :welcome
  end

  get '/config' do
    erb :configure
  end  
  
  post '/make_move' do
    @web_game.make_move(params[:square])

    selected_square = "square_#{params[:square]}"
    marker = cookies[:marker]
    if  square_empty?(selected_square)
      set_move_cookies(selected_square, marker) 
      gather_squares_from_cookies
      run_game
      erb :game
    else
      erb :game    
    end
  end

  get '/game' do
    @web_game
    @end_of_game_message = message
    erb :game
  end  

  def message
    if @web_game.over?
      "THE GAME IS OVER!!!"
    end
  end

  post '/game' do
    @configuration = Configuration.new(params[:marker], params[:opponent], params[:board_size], Sinatra_UI.new)
    @configuration.configure_game
    @web_game = WebGame.new

    erb :game
  end
    
  get '/restart' do
    erb :welcome
  end
  
  def square_empty?(selected_square)
    cookies[selected_square] != 'X' && cookies[selected_square] != 'O'
  end

  def set_move_cookies(square, marker)
      response.set_cookie(square, cookies[:marker])
      response.set_cookie('marker', opposite_marker)
      response.set_cookie('turn_incrementer', (cookies['turn_incrementer'].to_i + 1))
  end
  
  def run_game
    puts @current_board
    @new_game = New_Game.new(Sinatra_UI.new, board_size, first_player_peice, second_player_peice) 
    @current_board = new_game.board #=> ["", ""]
    new_game.run_game
  end


  def gather_squares_from_cookies
    @current_board = []
    (1..9).to_a.each do |n|
      @current_board << cookies["square_#{n}"] 
    end
    response.set_cookie('current_board', {:value => @current_board})
  end

  def clear_cookies
    empty_board.each do |n|
      response.set_cookie("square_#{n}", n)
    end
    response.set_cookie('turn_incrementer', 0)
    response.set_cookie('current_board', empty_board)
    response.set_cookie('marker', 'X')
  end

  def empty_board
    (1..9).to_a
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
    (1..params[:board_size].to_i**2).to_a
  end

  def squares_to_string
    integer_board.map {|square| square.to_s}
  end

  def setup_board
    @current_board = squares_to_string 
    @current_board.each {|n| response.set_cookie("square_#{n}", {:value => "#{n}"})}
  end
end
