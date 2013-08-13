require 'sinatra_ui'

describe Sinatra_UI do
  let(:ui) { Sinatra_UI.new}
  
  it "provides a message with given winner" do
    winner = "X"
    ui.display_winner('X').should == "Player X wins!"
  end

  it "provides a 'Tie Game' message" do
    ui.display_tie.should == "Tie Game!"
  end
end	
