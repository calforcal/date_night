require "spec_helper"

RSpec.describe BinarySearchTree do
  let!(:tree) { BinarySearchTree.new }
  describe "initialization" do
    it "exists" do
      expect(tree).to be_a BinarySearchTree
    end
  end

  describe "#insert" do
    it "can insert a node to the tree and return the tree level back" do
      expect(tree.insert(61, "Bill & Ted's Excellent Adventure")).to eq(0)
      expect(tree.insert(16, "Johnny English")).to eq(1)
      expect(tree.insert(92, "Sharknado 3")).to eq(1)
      expect(tree.insert(50, "Hannibal Buress: Animal Furnace")).to eq(2)
    end
  end
  
  describe "querying methods" do
    before(:each) do
      tree.insert(61, "Bill & Ted's Excellent Adventure")
      tree.insert(16, "Johnny English")
      tree.insert(92, "Sharknado 3")
      tree.insert(50, "Hannibal Buress: Animal Furnace")
    end

    describe "#find_bottom" do
      it "can find the bottom of the tree" do
        new_node = Node.new(45, "Newest Node")

        expect(tree.find_bottom(tree.head, new_node)).to be_a Node
        expect(tree.find_bottom(tree.head, new_node).score).to eq(50)
        expect(tree.find_bottom(tree.head, new_node).title).to eq("Hannibal Buress: Animal Furnace")
      end
    end

    describe "#include?" do
      it "can determine if a score is included in the tree" do
        expect(tree.include?(16)).to eq(true)
        expect(tree.include?(72)).to eq(false)
      end
    end

    describe "#depth_of" do
      it "can find the depth of a number in the tree" do
        expect(tree.depth_of(92)).to eq(1)
        expect(tree.depth_of(50)).to eq(2)
      end
    end

    describe "#max" do
      it "returns the maximum score of the Binary Tree" do
        expect(tree.max).to eq({"Sharknado 3"=>92})
      end
    end

    describe "#min" do
      it "returns the minimum score of the Binary Tree" do
        expect(tree.min).to eq({"Johnny English"=>16})
      end
    end

    describe "#sort" do
      it "can sort the binary tree and return it as an array of hashes" do
        expect(tree.sort).to eq([{"Johnny English"=>16},
                                 {"Hannibal Buress: Animal Furnace"=>50},
                                 {"Bill & Ted's Excellent Adventure"=>61},
                                 {"Sharknado 3"=>92}])

        tree.insert(98, "Animals United")
        tree.insert(58, "Armageddon")
        tree.insert(36, "Bill & Ted's Bogus Journey")
        tree.insert(93, "Bill & Ted's Excellent Adventure")
        tree.insert(86, "Charlie's Angels")
        tree.insert(38, "Charlie's Country")
        tree.insert(69, "Collateral Damage")

        expect(tree.sort).to eq([{ "Johnny English"=>16 },
                                 { "Bill & Ted's Bogus Journey"=>36 },
                                 { "Charlie's Country"=> 38 },
                                 { "Hannibal Buress: Animal Furnace"=>50 },
                                 { "Armageddon"=>58 },
                                 { "Bill & Ted's Excellent Adventure"=>61 },
                                 { "Collateral Damage"=>69 },
                                 { "Charlie's Angels"=>86 },
                                 { "Sharknado 3"=>92 },
                                 { "Bill & Ted's Excellent Adventure"=>93 },
                                 { "Animals United"=>98 }])
      end
    end

    describe "#load" do
      it "can take in a txt file through the load feature" do
        expect(tree.load('./data/movies_spec.txt')).to eq(6)

        expect(tree.sort).to eq([{"I Love You Phillip Morris"=>10},
                                 {"Johnny English"=>16},
                                 {"Experimenter"=>22},
                                 {"Hannibal Buress: Comedy Camisado"=>34},
                                 {"Love"=>41},
                                 {"Hannibal Buress: Animal Furnace"=>50},
                                 {"Bill & Ted's Excellent Adventure"=>61},
                                 {"Meet My Valentine"=>63},
                                 {"French Dirty"=>84},
                                 {"Sharknado 3"=>92}])
      end

      it "won't load in a score that already exists in the tree" do
        tree.insert(41, "Love")
        expect(tree.load('./data/movies_spec.txt')).to eq(5)

        expect(tree.sort).to eq([{"I Love You Phillip Morris"=>10},
                                 {"Johnny English"=>16},
                                 {"Experimenter"=>22},
                                 {"Hannibal Buress: Comedy Camisado"=>34},
                                 {"Love"=>41},
                                 {"Hannibal Buress: Animal Furnace"=>50},
                                 {"Bill & Ted's Excellent Adventure"=>61},
                                 {"Meet My Valentine"=>63},
                                 {"French Dirty"=>84},
                                 {"Sharknado 3"=>92}])
      end
    end
  end

  # NEW TEST BLOCK TO STOP BEFORE EACH

  describe "#health" do
    #health is broken into three different parts: Score, Num of Child Nodes, Percent Nodes that are its children
    before(:each) do
      tree.insert(98, "Animals United")
      tree.insert(58, "Armageddon")
      tree.insert(36, "Bill & Ted's Bogus Journey")
      tree.insert(93, "Bill & Ted's Excellent Adventure")
      tree.insert(86, "Charlie's Angels")
      tree.insert(38, "Charlie's Country")
      tree.insert(69, "Collateral Damage")
    end

    it "will return the health of the tree" do
      expect(tree.health(0)).to eq([[98, 7, 100]])
      expect(tree.health(1)).to eq([[58, 6, 85]])
      expect(tree.health(2)).to eq([[36, 2, 28], [93, 3, 42]])
    end

    describe "helper methods" do
      describe "#count_nodes_below" do
        it "can return node count from a certain node" do
          expect(tree.count_nodes_below(tree.head)).to eq(7)
          tree.node_count = 0
          expect(tree.count_nodes_below(tree.head.left_node)).to eq(6)
        end
      end

      describe "#get_nodes_at_level" do
        it "can receive a tree level and get all nodes on that level" do
          expect(tree.get_nodes_at_level(tree.head, 0, 0)).to eq([tree.head])
          expect(tree.get_nodes_at_level(tree.head, 0, 1)).to eq([tree.head.left_node])
        end
      end
    end
  end

  describe "Tree Shape Methods" do
    before(:each) do
      tree.insert(98, "Animals United")
      tree.insert(58, "Armageddon")
      tree.insert(36, "Bill & Ted's Bogus Journey")
      tree.insert(93, "Bill & Ted's Excellent Adventure")
      tree.insert(86, "Charlie's Angels")
      tree.insert(38, "Charlie's Country")
      tree.insert(69, "Collateral Damage")
    end

    #Leaves represents the # of nodes that have NO left or right value
    describe "#leaves" do
      it "returns the numbers of leaves in the tree" do
        expect(tree.leaves).to eq(2)

        tree.insert(35, "New Node")

        expect(tree.leaves).to eq(3)

        tree.insert(99, "New Node")

        expect(tree.leaves).to eq(4)
      end
    end

    #Height represents the maximum depth of the tree - AKA - the levels or 'rows' deep
    describe "#height" do
      it "returns the number of levels in the tree" do
        expect(tree.height).to eq(4)

        tree.insert(70, "New Node")

        expect(tree.height).to eq(5)

        tree.insert(71, "New Node")

        expect(tree.height).to eq(6)
      end
    end
  end

    # describe "#health observability" do
  #   before(:each) do
  #     tree.insert(98, "Animals United")
  #     tree.insert(58, "Armageddon")
  #     tree.insert(36, "Bill & Ted's Bogus Journey")
  #     tree.insert(93, "Bill & Ted's Excellent Adventure")
  #     tree.insert(86, "Charlie's Angels")
  #     tree.insert(88, "Charlie's Angels")
  #     tree.insert(38, "Charlie's Country")
  #     tree.insert(69, "Collateral Damage")
  #     tree.insert(99, "Collateral Damage")
  #   end

  #   it "prints out a log of the functions happening within #count_nodes_below" do
  #     tree.node_count = []
  #     puts tree.count_nodes_below(tree.head)
  #     # Returns 7 scores (count of 7, is correct)
  #     # Traverses left nodes in tree, when its at the bottom and left node is NULL, checks right node value, the right nodes left/right
  #     # As it bubbles back up the tree there is an unkown return [...] (I assume it is the stored value from recursion, basically signifying a jump in level)
  #     # EDIT: realized that having a global variable in the Tree Class was messing with the return value
  #     # Changed it to match the get_nodes method and it seems to have really simplified the whole operation
  #     # I'm fairly certain that the [...] was actually the whole array being returned inadvertently, a result of poor recursion.
  #   end

  #   it "prints out a log of the function within #get_nodes_at_level" do
  #     new_tree = BinarySearchTree.new
  #     new_tree.load('./data/movies.txt')
  #     new_tree.operations_performed = 0
  #     puts new_tree.get_nodes_at_level(new_tree.head, 0, 2)
  #     puts new_tree.operations_performed
  #     # OBSERVATIONS
  #     # No 'bubbling up' / unknown returns from this method. Everything is accounted for. (seemingly)
  #     # Added a guard statement that reduced the operations performed from a strict 297, to much, dependent on level searching for.
  #     # 
  #   end
  # end
end