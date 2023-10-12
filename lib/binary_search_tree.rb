class BinarySearchTree
  attr_reader :head
  attr_accessor :node_count, :operations_performed
  def initialize
    @head = nil
    @level = 0
    @max_num = 0
    @min_num = 0
    @node_count = 0
    @operations_performed = 0
  end

  def insert(score, title)
    new_node = Node.new(score, title)
    current_node = @head
    @level = 0

    place_node(new_node, current_node)
    return @level
  end

  def place_node(new_node, starting_node)
    placed = false
    while placed == false
      if @head.nil?
        @head = new_node
        placed = true
      else
        last_node = find_bottom(starting_node, new_node)
        last_node.score > new_node.score ? last_node.left_node = new_node : last_node.right_node = new_node
        placed = true
      end
    end
  end

  def include?(num)
    @level = 0
    node_finder(@head, num)
  end

  def node_finder(current_node, num)
    return false if current_node.nil?
    if current_node.score == num
      return true
    else
      @level += 1
      current_node.score > num ? node_finder(current_node.left_node, num) : node_finder(current_node.right_node, num)
    end
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

  def health(level)
    @node_count = 0
    total_nodes = count_nodes_below(@head)
    nodes = get_nodes_at_level(@head, 0, level)
    nodes.map do |node|
      @node_count = 0
      child_nodes = count_nodes_below(node)
      percent = (child_nodes / total_nodes.to_f) * 100
      [node.score, child_nodes, percent.to_i]
    end
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

  def count_nodes_below(starting_node)
    if starting_node.nil? then return else @node_count += 1 end
    if starting_node.left_node.nil? then else @node_count + count_nodes_below(starting_node.left_node) end
    if starting_node.right_node.nil? then else @node_count + count_nodes_below(starting_node.right_node) end
    @node_count
  end

  def get_nodes_at_level(starting_node, start_level=0, target_level)
    node_array = []
    if start_level > target_level then return node_array else end
    if target_level == 0 then return node_array << @head else end
    if target_level == start_level then node_array << starting_node else end
    if starting_node.left_node.nil? then else node_array << get_nodes_at_level(starting_node.left_node, start_level + 1, target_level) end
    if starting_node.right_node.nil? then else node_array << get_nodes_at_level(starting_node.right_node, start_level + 1, target_level) end
    node_array.flatten
  end

  # def count_nodes_below(starting_node)
  #   node_count = []
  #   if starting_node.nil?
  #     node_count << "NULL"
  #   else
  #     node_count << "Score: #{starting_node.score}"
  #   end

  #   if starting_node.left_node.nil?
  #     node_count << "LEFT NULL"
  #   else
  #     node_count << count_nodes_below(starting_node.left_node)
  #   end

  #   if starting_node.right_node.nil?
  #     node_count << "RIGHT NULL"
  #   else
  #     node_count << count_nodes_below(starting_node.right_node)
  #   end

  #   node_count
  # end

  # def get_nodes_at_level(starting_node, start_level=0, target_level)
  #   node_array = []

  #   if start_level > target_level
  #     @operations_performed += 1
  #     return node_array << "Went Too Far"
  #   else

  #   end

  #   if target_level == 0
  #     @operations_performed += 1
  #     node_array << @head 
  #   end

  #   if target_level == start_level
  #     @operations_performed += 1
  #     node_array << starting_node.score
  #   else 
  #     @operations_performed += 1
  #     node_array << "Wrong Level, #{start_level}"
  #   end

  #   if starting_node.left_node.nil?
  #     @operations_performed += 1
  #     node_array << "RIGHT NULL"
  #   else 
  #     @operations_performed += 1
  #     node_array << get_nodes_at_level(starting_node.left_node, start_level + 1, target_level)
  #   end

  #   if starting_node.right_node.nil?
  #     @operations_performed += 1
  #     node_array << "RIGHT NULL"
  #   else 
  #     @operations_performed += 1
  #     node_array << get_nodes_at_level(starting_node.right_node, start_level + 1, target_level)
  #   end

  #   node_array.flatten
  # end
end