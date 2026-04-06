function disassemble --wraps='objdump -M att --demangle --disassembler-color=extended --disassemble' --description 'alias disassemble=objdump -M att --demangle --disassembler-color=extended --disassemble'
    objdump -M att --demangle --disassembler-color=extended --disassemble $argv
end
