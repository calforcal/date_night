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
      end
    end
  end
end