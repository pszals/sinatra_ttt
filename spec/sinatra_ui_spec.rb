require 'spec_helper'
require 'sinatra_ui'

describe Sinatra_UI do
  
  let(:ui) { Sinatra_UI.new }
  
  it "returns opponent type of human" do
    ui.get_opponent.should == "human"
  end
  
  it "returns opponent type of computer" do
    ui.get_opponent.should == "computer"
  end
end