require 'sinatra_ui'

describe Sinatra_UI do
  
  let(:ui) { Sinatra_UI.new}

  it "gets the square to mark" do
    ui.get_square_to_mark.should == "X"
  end

  it "does nothing when puts_turn is called" do
    ui.puts_turn.should == nil
  end

  it "provides information of board when print_board is called" do
    board = "123456789"
    ui.print_board(board).should == "123456789"
  end

  it "does nothing when ask_for_square_to_mark is called" do
    ui.ask_for_square_to_mark.should == nil
  end

  it "provides a message with given winner" do
    winner = "X"
    ui.should_receive(:puts).with("Player X wins!")
    ui.display_winner('X')
  end

  it "provides a 'Tie Game' message" do
    ui.should_receive(:puts).with("Tie Game!")
    ui.display_tie
  end

  it "does nothing whn ask_to_restart is called" do
    ui.ask_to_restart.should == nil
  end

  it "has a get_input function" do
    ui.get_input.should == nil
  end

  it "places a marker" do
    ui.should_receive(:puts).with('X')
    ui.place_marker('X')
  end
end	
