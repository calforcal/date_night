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

  def sort
    collect_nodes(@head)    
  end

  def load(file)
    loaded = File.readlines(file).map(&:chomp)
    seperated = loaded.map { |element| element.split(", ") }
    parsed = seperated.map { |element| [element[0].to_i, element[1]] }
    count = parsed.length

    parsed.each do |pair|
      if include?(pair[0]) then count -= 1 else insert(pair[0], pair[1]) end
    end

    return count
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

  def collect_nodes(node)
    node_array = []
    if node.nil? then return else end
    node_array << { node.title => node.score }
    if node.left_node.nil? then node_array else node_array.prepend(collect_nodes(node.left_node)) end 
    if node.right_node.nil? then node_array else node_array << collect_nodes(node.right_node) end
    node_array.flatten
  end
end