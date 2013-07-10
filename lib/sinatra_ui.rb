class SinatraUI
  attr_reader :messages
  
  def self.messages
    @messages ||= {}
  end
  
  def self.print_board(board)
    messages[:board] = board
  end
end