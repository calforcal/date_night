class Node
  attr_reader :score, :title
  
  def initialize(score, title)
    @score = score
    @title = title
  end
end