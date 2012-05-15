#permutations

module RubyAlgorithms
  
  #Permutation of sumbols. Before permutation, sysbols convers its ansii code and performs genertation
  #
  # obj = RubyAlgorithms::Permutation.new "12345"
  # permutations_result = obj.turn
  # -> ["12345",......,"54321"]

  class Permutation

    attr_accessor :current_permutation

    def initialize str
      @current_permutation = str.to_s
    end

    def turn
      @result=[]
      @per_begin = []
      @current_permutation.each_byte {|e| @per_begin << e} # filling array with bytes
      @per_begin.sort!
      per_end = @per_begin.reverse #end result of permutation
      
      append_result #adding first result
      
      while true
        if @per_begin == per_end
          break
        end
        next_permutation # gets next permutation
        append_result # adds next permutation to result
      end
      @result
    end

    def next_permutation
      c_per=[]
      if @per_begin
        c_per = @per_begin
      else
        @current_permutation.each_byte {|e| c_per << e} 
      end
      
      index_m=0
      index_k=0
      
      #Treats elements in reverse mode
      c_per.each_index do |index|
        current_index = -(index+1) #reverse index of array
        
        if c_per[current_index] > c_per[current_index-1]
          
          index_m = current_index-1
          a_rest = c_per[index_m+1..-1].sort
          a_rest.each do |e|
            if c_per[index_m] < e
              i = c_per[0..index_m].length
              index_k = c_per[index_m+1..-1].index(e)+i
              break
            end
          end
          break
        end
      end

      if @per_begin
        @per_begin = c_per.change_elements(index_m,index_k)
      else
        c_per.change_elements(index_m,index_k).get_string_from_ansii
      end
    end
    
    def append_result
      @result << @per_begin.get_string_from_ansii
    end
    
  end

end

#adding to standart lib Array

class Array
    
  def change_elements(i,ii)
    first = self[i]
    self[i]=self[ii]
    self[ii]=first
    self[0..i] + self[i+1..-1].sort
  end
    
  def get_string_from_ansii
    str=""
    self.each {|e| str << e}
    str
  end

end

