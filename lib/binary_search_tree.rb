class BinarySearchTree
  attr_reader :head
  def initialize
    @head = nil
    @level = 0
  end

  def insert(score, title)
    new_node = Node.new(score, title)
    placed = false
    current_node = @head
    @level = 0

    while placed == false
      if @head.nil?
        @head = new_node
        placed = true
        break
      else
        last_node = find_bottom(current_node, new_node)
        last_node.score > new_node.score ? last_node.left_node = new_node : last_node.right_node = new_node
        placed = true
        break
      end
    end
    return @level
  end

  def find_bottom(current_node, new_node)
    while current_node != nil
      if current_node.score > new_node.score
        last_node = current_node
        current_node = current_node.left_node
        @level += 1
      else
        last_node = current_node
        current_node = current_node.right_node
        @level += 1
      end
    end
    return last_node
  end
end