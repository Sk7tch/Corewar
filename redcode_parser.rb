module Corewar
	
	class Redcode
		def self.parse(lines)
			seq = []
			lines.each do |line|
				seq << parse_line(line)
				puts "#{seq.last}"
			end
			seq
		end
		
		private
		
		def self.parse_line(line)
			rgx = /([A-Z]{3})\s+([\$\*\@\{\}\<\>\#]?)(-?\d+)[,\s]*([\$\*\@\{\}\<\>\#]?)(-?\d+)?/
			res = line.strip.match(rgx)			
			if (["JMP", "SPL"].include?(res[1]) and (res[5].nil? or res[5].empty?))
				Command.new(res[1], [res[4], res[5]], [res[2], res[3]])
			else
				Command.new(res[1], [res[2], res[3]], [res[4], res[5]])
			end			
		end
	end
	
end