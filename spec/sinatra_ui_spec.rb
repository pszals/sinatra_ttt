require 'sinatra_ui'

describe Sinatra_UI do
  it "gets the square to mark" do
    described_class.get_square_to_mark.should == "X"
  end
end	
