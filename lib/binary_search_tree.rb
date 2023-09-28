class BinarySearchTree
  attr_reader :head
  def initialize
    @head = nil
    @level = 0
    @max_num = 0
    @min_num = 0
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

  def include?(num)
    current_node = @head
    @level = 0
    while current_node != nil
      if current_node.score == num
        return true
      else
        current_node.score > num ? current_node = current_node.left_node : current_node = current_node.right_node
        @level += 1
      end
    end
    return false
  end

  def depth_of(num)
    include?(num) ? @level : nil
  end

  def max
    @max_num = @head.score
    current_node = @head
    while current_node.right_node != nil
      max_node = current_node.right_node
      current_node = current_node.right_node
    end
    return {max_node.title => max_node.score}
  end

  def min
    @min_num = @head.score
    current_node = @head
    while current_node.left_node != nil
      min_node = current_node.left_node
      current_node = current_node.left_node
    end
    return {min_node.title => min_node.score}
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