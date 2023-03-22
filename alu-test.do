vsim alu
add wave -position insertpoint sim:/alu/*

# Test1
# bitwise not
# 	operand1 = 0xf0f0f0f0
#	expectedResult = 0x0f0f0f0f
#	expectedError = 0x0
force -freeze sim:/alu/operand1 32'hf0f0f0f0 0
force -freeze sim:/alu/operation 4'hb 0
run
pause

# Test for non-existant operation
#	expectedResult = 0x00000000
force -freeze sim:/alu/operation 4'hc 0
run

# Test2
# multiplaction
#	operand1 = 0x5
#	operand2 = 0x3
#	expectedResult = 0xf
#	expectedError = 0x0
force -freeze sim:/alu/operand1 32'h00000003 0
force -freeze sim:/alu/operand2 32'h00000005 0
force -freeze sim:/alu/operation 4'h4 0
run
