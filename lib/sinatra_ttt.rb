require 'sinatra'
require './lib/sinatra_ui'

class SinatraTTT < Sinatra::Base
  get '/' do
    erb :welcome
  end
  
  post '/config' do
    params[:player]
  end
  
  get '/config' do
    erb :configure
  end

  post '/game' do
     SinatraUI.print_board(' 1 | 2 | 3 ') 
  end
end