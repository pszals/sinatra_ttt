$LOAD_PATH.unshift File.expand_path('../../../ruby_tictactoe/lib', __FILE__)

require 'sinatra'
require 'sinatra/cookies'
require './lib/sinatra_ui'
require 'webgame'
require 'bundler'
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
    @web_game.make_move(params[:square])
    erb :game    
  end

  get '/game' do
    erb :game
  end  

  def message
    if @web_game.over?
      "THE GAME IS OVER!!!"
    end
  end

  post '/game' do
    @configuration = Configuration.new(params[:marker], params[:opponent], params[:board_size], Sinatra_UI.new)
    @web_game = WebGame.new(@configuration)
    erb :game
  end
 
  get '/restart' do
    erb :welcome
  end
end
