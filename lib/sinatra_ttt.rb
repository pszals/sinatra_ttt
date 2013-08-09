$LOAD_PATH.unshift File.expand_path('../../../ruby_tictactoe/lib', __FILE__)

require 'sinatra'
require 'sinatra/cookies'
require './lib/sinatra_ui'
require 'webgame'
require 'bundler'
require 'configuration'

Bundler.require(:default)
Bundler.setup

class Sinatra_TTT < Sinatra::Base
  
  attr_reader :params, :web_game
  
  get '/' do
    erb :welcome
  end

  get '/config' do
    erb :configure
  end  
  
  post '/make_move' do
    @@web_game.make_move(params[:square])
    @board = @@web_game.board
    @end_of_game_message = message
    erb :game    
  end

  post '/game' do
    start_up_game(params[:marker], params[:opponent], params[:board_size])
    @board = @@web_game.board
    erb :game
  end
 
  get '/restart' do
    erb :welcome
  end

  def start_up_game(mark, opponent, board_size)
    configs = Configuration.new(mark, opponent, board_size, Sinatra_UI.new)
    @@web_game = WebGame.new(configs)
  end
 
  def message
    @@web_game.game_over_message
  end
end
