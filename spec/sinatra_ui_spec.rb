require 'spec_helper'
require 'sinatra_ui'

describe SinatraUI do
  it 'displays a board' do
    SinatraUI.print_board('This is a board')
    SinatraUI.messages[:board].should == 'This is a board'
  end
end