class Node
  attr_reader :score, :title
  attr_accessor :left_node, :right_node

  def initialize(score=nil, title=nil)
    @score = score
    @title = title
    @left_node = nil
    @right_node = nil
  end
end