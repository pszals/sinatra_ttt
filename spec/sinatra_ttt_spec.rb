require 'sinatra_ttt'
require 'spec_helper'

def app
  SinatraTTT
end

describe SinatraTTT do
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
      TTT.should_receive(:configure_game).with(marker, opponent, board_size)
      
      post '/config', marker: marker, opponent: opponent, board_size: board_size
    end
  end
  
  context 'making a move on the board' do
    it 'sends a selected move to the board' do
      marker = 'X'
      square   = '1'      
      TTT.should_receive(:make_move).with(square, marker)
      
      post '/make_move', marker: marker, square: square
    end
  end
  
  context 'outputting the board' do
    it 'puts the board on the screen in the browser' do
      board = '123456789'
      TTT.should_receive(:output_board).with(board)
      
      get '/output_board', board: '123456789'
    end
  end
  
  context 'restarting the game' do
    it 'asks user to restart' do      
      get '/restart'
      last_response.status.should == 200
    end
    
    it 'sends a selection to restart' do
      restart_choice = 'yes'
      TTT.should_receive(:restart).with(restart_choice)
      
      post '/restart', restart_choice: restart_choice
    end
  end
  
  # Test that params contains options for player
  # Start game should be at root and that ^
end