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
    erb :game    
    puts @@web_game.board.current_board
  end

  get '/game' do
    erb :game
  end  

  def message
    if @@web_game.over?
      "THE GAME IS OVER!!!"
    end
  end

  def start_up_game(mark, opponent, board_size)
    configs = Configuration.new(mark, opponent, board_size, Sinatra_UI.new)
    @@web_game = WebGame.new(configs)
  end

  post '/game' do
#    configs = Configuration.new(params[:marker], params[:opponent], params[:board_size], Sinatra_UI.new)
#    @web_game = WebGame.new(configs)
    start_up_game(params[:marker], params[:opponent], params[:board_size])
    erb :game
  end
 
  get '/restart' do
    erb :welcome
  end
end
