require 'sinatra'
require './lib/sinatra_ui'

class SinatraTTT < Sinatra::Base
  get '/' do
    "Welcome to TTT! <a href=\"/game\">Click here to play a game</a>"
  end
  
  get '/game' do
    'Some options'
  end

  post '/game' do
     SinatraUI.print_board(' 1 | 2 | 3 ') 
  end
end