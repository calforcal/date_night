require "spec_helper"

RSpec.describe BinarySearchTree do
  describe "initialization" do
    it "exists" do
      tree = BinarySearchTree.new
      expect(tree).to be_a BinarySearchTree
      expect(tree.left_node).to eq(nil)
      expect(tree.right_node).to eq(nil)
    end
  end
end