require "spec_helper"

RSpec.describe Node do
  describe "initialization" do
    it "exists" do
      node = Node.new(1, "Worst Movie Ever")
      expect(node).to be_a Node
      expect(node.score).to eq(1)
      expect(node.title).to eq("Worst Movie Ever")
      expect(node.left_node).to eq(nil)
      expect(node.right_node).to eq(nil)
    end
  end
end