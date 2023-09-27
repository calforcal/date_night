require "spec_helper"

RSpec.describe BinarySearchTree do
  describe "initialization" do
    it "exists" do
      tree = BinarySearchTree.new
      expect(tree).to be_a BinarySearchTree
    end
  end
end