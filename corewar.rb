require_relative 'memory'
require_relative 'cmds'
require_relative 'redcode_parser'
require_relative 'vm'
require_relative 'indexes'

require 'awesome_print'

include Corewar

j1 = File.readlines('viking.redcode')
j2 = File.readlines('gaulois.redcode')

puts "-----------------"
seq1 = Redcode.parse(j1)
puts "-----------------"
seq2 = Redcode.parse(j2)
puts "-----------------"

memory = Memory.new
vm = Vm.new(memory, [seq1, seq2])
vm.run
