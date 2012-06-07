#require "spec_helper"
require "ruby_algorithms/permutation"

describe RubyAlgorithms::Permutation do
  
#  before(:all) do
#    
#  end
  
  describe "#next_permutation" do
    it "should generate next permutation for 12345 with lexicographical method" do
      @obj = RubyAlgorithms::Permutation.new "12345"  

      @obj.next_permutation
      @obj.get_current_permutation.should == "12354"    

      @obj.permutation_string= "12354"
      @obj.next_permutation
      @obj.get_current_permutation.should == "12435"    

      @obj.permutation_string = "12435"
      @obj.next_permutation
      @obj.get_current_permutation.should == "12453"    

      @obj.permutation_string = "12453"
      @obj.next_permutation
      @obj.get_current_permutation.should == "12534"    
    end

    it "should generate next permutation for 12345 with recurtion method" do
      @obj = RubyAlgorithms::Permutation.new "12345", true
      @obj.next_permutation

      @obj.get_current_permutation.should == "12354"

      @obj.permutation_string = "12354"; @obj.next_permutation
      @obj.get_current_permutation.should == "12534"

      @obj.permutation_string = "12534"; @obj.next_permutation
      @obj.get_current_permutation.should == "15234"

    end
  end
  
  describe "#turn" do
    it "should roll and return all of permutations with lexicographical method" do
      @obj_per = RubyAlgorithms::Permutation.new "1234"
      arr_permutations = @obj_per.turn
      arr_permutations.should be_include("1243")
      arr_permutations.should be_include("1423")
      arr_permutations.should be_include("4123")
      arr_permutations.should be_include("4132")
    end

    it "should roll and return all of permutations with recurtion method" do
      @obj_per = RubyAlgorithms::Permutation.new "1234", true
      arr_permutations = @obj_per.turn
      arr_permutations.length.should == 24
      arr_permutations.should be_include("1243")
      arr_permutations.should be_include("1423")
      arr_permutations.should be_include("4123")
      arr_permutations.should be_include("4132")
    end
    
  end

  describe "Array#move_by_direction" do
    it "should move chose element by indication" do
      arr = [[1,-1],[2,-1],[3,-1],[4,-1]]
      var = arr.move_by_direction([4,-1],-1)
      var.should be_true
      arr.should == [[1,-1],[2,-1],[4,-1],[3,-1]]
      arr.move_by_direction([4,-1],-1)
      arr.should == [[1,-1],[4,-1],[2,-1],[3,-1]]
      arr.move_by_direction([4,-1],-1)
      arr.should == [[4,-1],[1,-1],[2,-1],[3,-1]]

      arr.move_by_direction([4,-1],-1)
      arr.should == [[4,1],[1,-1],[3,-1],[2,-1]]
      arr.move_by_direction([4,1],1)
      arr.should == [[1,-1],[4,1],[3,-1],[2,-1]]
      arr.move_by_direction([4,1],1)
      arr.should == [[1,-1],[3,-1],[4,1],[2,-1]]
      arr.move_by_direction([4,1],1)
      arr.should == [[1,-1],[3,-1],[2,-1],[4,1]]

      arr.move_by_direction([4,1],1)
      arr.should == [[3,-1],[1,-1],[2,-1],[4,-1]]
      arr.move_by_direction([4,-1],-1)
      arr.should == [[3,-1],[1,-1],[4,-1],[2,-1]]
      arr.move_by_direction([4,-1],-1)
      arr.should == [[3,-1],[4,-1],[1,-1],[2,-1]]
      arr.move_by_direction([4,-1],-1)
      arr.should == [[4,-1],[3,-1],[1,-1],[2,-1]]

      arr.move_by_direction([4,-1],-1)
      arr.should == [[4,1],[3,1],[2,-1],[1,-1]]
      arr.move_by_direction([4,1],1)
      arr.should == [[3,1],[4,1],[2,-1],[1,-1]]
      arr.move_by_direction([4,1],1)
      arr.should == [[3,1],[2,-1],[4,1],[1,-1]]
      arr.move_by_direction([4,1],1)
      arr.should == [[3,1],[2,-1],[1,-1],[4,1]]

    end
  end
  
end





 