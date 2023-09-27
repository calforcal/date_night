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
      expect(tree.insert(16, "Johnny English")).to eq(0)
      expect(tree.insert(92, "Sharknado 3")).to eq(0)
      expect(tree.insert(50, "Hannibal Buress: Animal Furnace")).to eq(0)
    end
  end
end