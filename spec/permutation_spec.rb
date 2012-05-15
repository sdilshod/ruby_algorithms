#require "spec_helper"
require "ruby_algorithms/permutation"

describe RubyAlgorithms::Permutation do
  
#  before(:all) do
#    
#  end
  
  describe "#next_permutation" do
    it "should generate next permutation for 12345" do
      @obj_per = RubyAlgorithms::Permutation.new "12345"  

      n_p = @obj_per.next_permutation
      n_p.should == "12354"    
      @obj_per.current_permutation= "12354"
      n_p = @obj_per.next_permutation
      n_p.should == "12435"    

      @obj_per.current_permutation= "12435"
      n_p = @obj_per.next_permutation
      n_p.should == "12453"    

      @obj_per.current_permutation= "12453"
      n_p = @obj_per.next_permutation
      n_p.should == "12534"    
    end
  end
  
  describe "#turn" do
    it "should roll and return all of permutations" do
      @obj_per = RubyAlgorithms::Permutation.new "122"
      arr_permutation = @obj_per.turn
      arr_permutation.length.should == 3
      arr_permutation.should be_include("212")
      arr_permutation.should be_include("221")

      @obj_per.current_permutation = "12344"
      arr_permutation = @obj_per.turn
      arr_permutation.should be_include("44321")
    end
  end
  
end
