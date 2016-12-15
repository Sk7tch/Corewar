module Corewar

	class Queue		
		def initialize(nb_warriors, start_positions)
			@nb_warriors = nb_warriors
			@process = Array.new(@nb_warriors) { Array.new }
			start_positions.each.with_index { |value, index| @process[index] << value }			
			@current_process = Array.new(@nb_warriors, 0)
			@new_process = -1
			@current_warrior = 0
		end
		
		def current_process
			@current_process[@current_warrior]
		end
		
		def get
			@process[@current_warrior][@current_process[@current_warrior]]
		end
		
		def set(index_process)
			@process[@current_warrior][@current_process[@current_warrior]] = index_process
		end
		
		def next
			@current_process[@current_warrior] = (@current_process[@current_warrior] + 1) % @process[@current_warrior].size
			@process[@current_warrior] << @new_process if @new_process > -1
			@new_process = -1
			@current_warrior = (@current_warrior + 1) % @nb_warriors
		end
		
		def new_process(index_process)
			@new_process = index_process
		end
		
		def kill_process
			@process[@current_warrior].delete(@current_process)
			raise "Warrior #{@current_warrior}, you loose !" if @process[@current_warrior].size <= 0
		end
	end
	
end