class Node
  attr_reader :score, :title, :left_node, :right_node

  def initialize(score, title)
    @score = score
    @title = title
    @left_node = nil
    @right_node = nil
  end
end