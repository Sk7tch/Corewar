module Corewar

	class Memory
		attr_reader :size
	
		def initialize(size = 32)
			@size = size
			@seq = Array.new(size, Command.new("DAT", ["", "0"], ["", "0"]))		
		end
		
		def load(index, seq)
			seq.each_with_index { |val, i| @seq[index + i] = val }
		end
		
		def [](x)
			@seq[x % @size]
		end
		
		def []=(x, val)
			@seq[x % @size] = val if val.is_a?(Command)
		end
		
		def adress(modifier, value, index)		
			num = case modifier
				when Command::MODIFIERS['#'] then 
					index
				when Command::MODIFIERS['$'] then 
					index + value
				when Command::MODIFIERS['@'] then
					index + value + (@seq[index + value]).source_value
				when Command::MODIFIERS['*'] then
					index + value + (@seq[index + value]).destination_value
				else
					0
			end
			num % @size
		end
		
		def move_index(index, step)
			(index + step) % @size
		end
	end

end