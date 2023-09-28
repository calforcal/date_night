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

  describe "#find_bottom" do
    it "can find the bottom of the tree" do
      new_node = Node.new(45, "Newest Node")

      tree.insert(61, "Bill & Ted's Excellent Adventure")
      tree.insert(16, "Johnny English")
      tree.insert(92, "Sharknado 3")
      tree.insert(50, "Hannibal Buress: Animal Furnace")

      expect(tree.find_bottom(tree.head, new_node)).to be_a Node
      expect(tree.find_bottom(tree.head, new_node).score).to eq(50)
      expect(tree.find_bottom(tree.head, new_node).title).to eq("Hannibal Buress: Animal Furnace")
    end
  end

  describe "#include?" do
    it "can determine if a score is included in the tree" do
      tree.insert(61, "Bill & Ted's Excellent Adventure")
      tree.insert(16, "Johnny English")
      tree.insert(92, "Sharknado 3")
      tree.insert(50, "Hannibal Buress: Animal Furnace")

      expect(tree.include?(16)).to eq(true)
      expect(tree.include?(72)).to eq(false)
    end
  end
end