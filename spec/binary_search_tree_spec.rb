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
    it "will return the health of the tree" do
      tree.insert(98, "Animals United")
      tree.insert(58, "Armageddon")
      tree.insert(36, "Bill & Ted's Bogus Journey")
      tree.insert(93, "Bill & Ted's Excellent Adventure")
      tree.insert(86, "Charlie's Angels")
      tree.insert(38, "Charlie's Country")
      tree.insert(69, "Collateral Damage")

      expect(tree.health(0)).to eq([[98, 7, 100]])
      expect(tree.health(1)).to eq([[58, 6, 85]])
      expect(tree.health(2)).to eq([[36, 2, 28], [93, 3, 42]])
    end
  end
end