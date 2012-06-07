#permutations

module RubyAlgorithms
  
  #Permutation of sumbols. Before permutation, symbols convers its ansii code and performs genertation
  #
  # LEXICOGRAPHICAL_METHOD
  # obj = RubyAlgorithms::Permutation.new "12345"
  # permutations_result = obj.turn
  # -> ["12345",......,"54321"]
  #
  # RECURTION_METHOD
  # In this method generates with direction(-1 : "left", 1 : "right")
  # obj = RubyAlgorithms::Permutation.new "12345", true
  # permutations_result = obj.turn
  # -> ["12345","12354","12534","15234","51234","51243","15243"......]

  class Permutation
    
    LEXICOGRAPHICAL_METHOD = "lexicographical"
    RECURTION_METHOD = "recurtion"


    attr_accessor :permutation_string #, :permutation_method

    def initialize str, recurtion_method=false
      unless recurtion_method
        @permutation_method = LEXICOGRAPHICAL_METHOD
      else
        @permutation_method = RECURTION_METHOD
      end
      @permutation_string = str.to_s
    end

    def turn
      @result=[] # blank array which holds result of permutations
      @per_begin = []
      if lexico_method?
        
        @permutation_string.each_byte {|e| @per_begin << e} # filling array with bytes
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

      else
        # filling array with elements and his direction(-1 :- left; 1 :- right)
        @permutation_string.each_byte {|e| @per_begin << [e,-1]} 
        @per_begin.sort!
        @el_whose_moves = @per_begin[-1] # element whose will move in array

        append_result #adding first permutation to rezult
      
        while true 
          if next_permutation #if gets next permutation, will add new permutation to result
            append_result            
          else
            break
          end
        end
      end

      @result
    end

    #This method returns next permutation

    def next_permutation
      c_per=[]
      if @per_begin
        c_per = @per_begin
      else
        if lexico_method?
          @permutation_string.each_byte {|e| c_per << e}
        else
          @permutation_string.each_byte {|e| c_per << [e,-1]}  
          @el_whose_moves = c_per.sort[-1]
        end
      end
      
      if lexico_method?      
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
                i = c_per[0..index_m].  
                index_k = c_per[index_m+1..-1].index(e)+i
                break
              end
            end
            break
          end
        end
      else
        if c_per.move_by_direction(@el_whose_moves,@el_whose_moves[1])
          @per_begin = c_per
          return true #next permutation generated
        else
          return false
        end
      end

      @per_begin = c_per.change_elements(index_m,index_k)
    end
    
    def append_result
      @result << @per_begin.get_string_from_ansii if lexico_method?
      @result << @per_begin.get_string_from_ansii(true) unless lexico_method?
    end

    def get_current_permutation
      return @per_begin.get_string_from_ansii(true) unless lexico_method?
      return @per_begin.get_string_from_ansii if lexico_method?
    end

    def lexico_method?
      return true if @permutation_method == LEXICOGRAPHICAL_METHOD
      return false
    end
    
  end

end

#adding to standart lib Array

class Array
    
  def change_elements(i,ii,sorting=true)
    first = self[i]
    self[i]=self[ii]
    self[ii]=first
    self[0..i] + self[i+1..-1].sort if sorting
  end
    
  def get_string_from_ansii(two_dimensional_arr=false)
    str=""
    self.each {|e| str << e} unless two_dimensional_arr
    self.each {|e| str << e[0]} if two_dimensional_arr
    str
  end

  def move_by_direction(element,indication)
    moved=false; #indication that moves the element or don't

    current_index, changeable_index, rest_array_range, indication_to_current_element = get_change_index_and_rest_of_array(element,indication)
    return moved if current_index.nil?

    #if rest of array range changes, we will iterate rest of array
    unless rest_array_range == (0..self.length-1)
      temp_arr = self[rest_array_range]
      self[current_index][1] = indication_to_current_element
      while true
        max_val = temp_arr.get_maximal_value
        current_index, changeable_index, rest_array_range, indication_to_current_element = temp_arr.get_change_index_and_rest_of_array(max_val,max_val[1])

        if current_index.nil?
          moved=false
          break
        end
        current_index_for_self = self.index(temp_arr[current_index])
        changeable_index_for_self = self.index(temp_arr[changeable_index])
        if rest_array_range == (0..temp_arr.length-1)
          change_elements(changeable_index_for_self,current_index_for_self,false)
          moved = true; #element moved
          break
        else
          self[current_index_for_self][1] = indication_to_current_element
          temp_arr = temp_arr[rest_array_range]
        end
      end
    else
      change_elements(changeable_index,self.index(element),false)
      moved = true  #element moved
    end
    moved #self
  end

  def get_maximal_value
    self.sort[-1] 
  end


  def get_change_index_and_rest_of_array(element,indication)
    return nil if self.length == 1
    indication_to_current_element = 1

    current_index = self.index(element) #index of current element 
    rest_array_range = (0..self.length-1)
    i = 1; i = -1 if indication < 0

    changeable_index = self.index(element)+i
    if changeable_index < 0 
      rest_array_range = (1..-1)
    elsif changeable_index > self.length-1
      rest_array_range = (0..-2)
      indication_to_current_element = -1
    end

    return current_index, changeable_index, rest_array_range, indication_to_current_element

  end

end


 