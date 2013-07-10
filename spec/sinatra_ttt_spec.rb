require 'sinatra_ttt'
require 'spec_helper'

def app
  SinatraTTT
end

describe SinatraTTT do
  describe '/' do
    it 'retrieves a 200 response' do
      get '/'
      last_response.status.should == 200
    end
  end
  
  describe '/game' do
    it 'retrieves players options' do
      post '/game', {"size" => '3', "player_one" => "h",
                     "player_two" => "h"}
      last_response.status.should == 200
      last_response.body.should include(" 1 | 2 | 3 ")
    end
  end
  # Test that params contains options for player
  # Start game should be at root and that ^
end