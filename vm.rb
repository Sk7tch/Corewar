module Corewar

	class Vm
		def initialize(memory, seqs)
			@memory = memory
			@nb_warriors = seqs.size
			@current_warrior = 0
			positions = (0...@nb_warriors).to_a.map { |i| (@memory.size / @nb_warriors) * i }
			@queue = Queue.new(@nb_warriors, positions)
			seqs.each_with_index { |seq, index| @memory.load(positions[index], seq) }		
		end
		
		def run
			8000.times do
				s_command = []
				@nb_warriors.times do
					process_index = @queue.get
					command = @memory[process_index]
					s_command << "#{command} P#{@queue.current_process}"
					step = execute(command, process_index)						
					@queue.set(@memory.move_index(process_index, step)) if step > 0
					@queue.next
				end
				puts "%.15s --- %.15s" % s_command
				sleep(0.5)
			end
		end
		
		private
		
		def execute(command, process_index)			
			src_addr = @memory.adress(command.source_modifier, command.source_value, process_index)
			dest_addr = @memory.adress(command.destination_modifier, command.destination_value, process_index)
			if (Command::NAMES.key?(command.name)) # Safe execution
				return self.send(command.name.downcase, command, [src_addr, dest_addr])
			else
				raise "Call unauthorize method: #{command.name}"
			end
		end
					
		# COMMANDS
		# return :next_instruction
		
		def dat(command, addrs)
			@queue.kill_proccess(@current_warrior)
			1
		end
		
		def operation(command, addrs, ope)
			@memory[addrs.last].destination_value = @memory[addrs.first].source_value.public_send(ope, @memory[addrs.last].destination_value)
			1
		end
		
		def add(command, addrs)
			operation(command, addrs, "+")
		end
		
		def sub
			operation(command, addrs, "-")
		end

		def mul
			operation(command, addrs, "*")
		end

		def div
			operation(command, addrs, "/")
		end
		
		def mod
			operation(command, addrs, "%")
		end
		
		def jmp(command, addrs)
			@queue.set(addrs.last)
			0
		end
		
		def jmz(command, addrs)
			if @memory[addrs.first].source_value == 0
				jmp(command, addrs) 
			else
				1
			end
		end
		
		def jmn(command, addrs)
			if @memory[addrs.first].source_value != 0
				jmp(command, addrs) 
			else
				1
			end
		end
		
		def mov(command, addrs)
			@memory[addrs.last] = @memory[addrs.first]
			1
		end
		
		def djn(command, addrs)
			if ((@memory[addrs.first].source_value -= 1) == 0)
				jmp(command, addrs)			
			else
				1
			end
		end
		
		def cmp(command, addrs)
			if (@memory[addrs.first].source_value == @memory[addrs.last].destination_value)
				2
			else
				1
			end
		end
		
		def seq(command, addrs)
			cmp(command, addrs)
		end
		
		def sne(command, addrs)
			if (@memory[addrs.first].source_value != @memory[addrs.last].destination_value)
				2
			else
				1
			end
		end
		
		def spl(command, addrs)
			@queue.new_process(addrs.last)
			1
		end
		
		def nop(command, addrs)
			1
		end		
	end
end