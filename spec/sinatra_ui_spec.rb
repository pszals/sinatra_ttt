require 'sinatra_ui'

describe Sinatra_UI do
  let(:ui) { Sinatra_UI.new}
  
  it "provides a message with given winner" do
    winner = "X"
    ui.should_receive("Player X wins!")
    ui.display_winner('X')
  end

  it "provides a 'Tie Game' message" do
    ui.should_receive("Tie Game!")
    ui.display_tie
  end
end	
