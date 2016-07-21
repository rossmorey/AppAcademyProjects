require 'rspec'
require 'tdd'

=begin
Instructions: implement all of the pending specs (the `it` statements without blocks)!
 Be sure to look over the solutions when you're done.
=end

describe "#my_uniq" do
    it "removes duplicates" do
      test_array1 = [1,2,1,3,3]
      expect(test_array1.my_uniq).to eq([1,2,3])
    end

    it "given an empty array -> return empty array" do
      expect([].my_uniq).to eq([])
    end

    it " array with no duplicates returns self." do
      expect([1,2,3,4,5,6,7,8,9,10]).to eq([1,2,3,4,5,6,7,8,9,10])
    end
  end


  describe "#two_sum" do
    it "correctly returns indices that sum to zero" do
      arr = [-1, 0, 2, -2, 1]
      expect(arr.two_sum).to eq([[0,4], [2,3]])
    end

    it "given empty array, returns empty array" do
      arr = []
      expect(arr.two_sum).to eq(arr)
    end

    it "return self if no elements sum to zero" do
      arr = [-1, -2, -3, -4, -5]
      expect(arr.two_sum).to eq([])
    end
  end


  describe "#my_transpose" do
    it "correctly flips rows with cols with 2D(3x3) array" do
      rows = [
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8]
        ]
      cols = [
        [0, 3, 6],
        [1, 4, 7],
        [2, 5, 8]
        ]
        expect(rows.my_transpose).to eq(cols)
    end
  end

  describe "#stock_picker" do
    it "picks indices with greatest difference(low val first)" do
      arr = [0,1,2,3,4,5,6,7,8,9,10]
      expect(arr.stock_picker).to eq([0,10])
    end

    it "returns empty array if stock values are only decreasing" do
      arr = [10,9,8,7,6,5,4,3,2,1]
      expect(arr.stock_picker).to eq([0,0])
    end
  end



#   describe "#add_ingredient" do
#     it "adds an ingredient to the ingredients array"
#   end
#
#   describe "#mix!" do
#     it "shuffles the ingredient array"
#   end
#
#   describe "#eat" do
#     it "subtracts an amount from the quantity"
#
#     it "raises an error if the amount is greater than the quantity"
#   end
# end
