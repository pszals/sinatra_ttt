require 'sinatra'
require 'sinatra_ui'

class SinatraTTT < Sinatra::Base
  get '/' do
    'Hello World'
  end
  
  post '/game' do
     SinatraUI.print_board(' 1 | 2 | 3 ')
  end
end
