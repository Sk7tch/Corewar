module Corewar

	class Command
				
		NAMES = {
			"DAT" => 0, "MOV" => 1, "ADD" => 2, "SUB" => 3, "MUL" => 4, "DIV" => 5,
			"MOD" => 6, "JMP" => 7, "JMZ" => 8, "JMN" => 9, "DJN" => 10, "SPL" => 11,
			"CMP" => 12, "SEQ" => 13, "SNE" => 14, "SLT" => 15, "LDP" => 16, "STP" => 17,
			"NOP" => 18
		}.freeze
		
		MODIFIERS = {
			'#' => 0, '$' => 1, '@' => 2, '*' => 3
		}.freeze
		
		# ------------------------------------------
		attr_reader :name
		attr_reader :source_modifier
		attr_accessor :source_value
		attr_reader :destination_modifier
		attr_accessor :destination_value
		
		def initialize(code_cmd, a_field, b_field)
			@name = (NAMES.key?(code_cmd)) ? code_cmd : "DAT"
			@source_modifier = MODIFIERS[a_field.first] || 1
			@destination_modifier = MODIFIERS[b_field.first] || 1
			@source_value = a_field.last.to_i
			@destination_value = b_field.last.to_i
		end
		
		def to_s
			s_moda = MODIFIERS.select { |k, v| v == @source_modifier }.first.first
			s_modb = MODIFIERS.select { |k, v| v == @destination_modifier }.first.first
			"#{@name} #{s_moda}#{@source_value}, #{s_modb}#{@destination_value}"
		end
	end
	
end