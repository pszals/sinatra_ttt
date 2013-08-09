require 'sinatra_ttt'
require 'spec_helper'

def app
  Sinatra_TTT
end

describe Sinatra_TTT do
  let(:ttt) { Sinatra_TTT.new }
  

  describe 'ttt home page' do
    it 'retrieves a 200 response' do
      get '/'
      last_response.status.should == 200
    end
  end
  
  context 'configuring the game' do
    it 'sends the opponent type, board size and player peice to be configured' do
      marker     = 'X'
      opponent   = 'human'
      board_size = '3'
      post '/game', marker: marker, opponent: opponent, board_size: board_size
    end
  end
  
  context 'making a move on the board' do
    it 'sends a selected move to the board' do
      marker = 'X'
      square   = '1'      
      ttt.web_game.should_receive(:make_move)      
      post '/make_move'   
    end
  end
   
  context 'restarting the game' do
    it 'asks user to restart' do      
      get '/restart'
      last_response.status.should == 200
    end
  end
end
