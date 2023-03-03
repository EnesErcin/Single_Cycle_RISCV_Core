`timescale 1ns / 1ps

module Instruction_Memory(
output  [31:0] INSTRUCTION,
input   [31:0]PC
 );

wire [31:0] PC_for_ins ; assign PC_for_ins = PC[31:2];

reg [31:0] Instruction_Bank [31:0];
initial  $readmemh("Load_Store_StackPointer.mem", Instruction_Bank);

assign INSTRUCTION = Instruction_Bank[PC_for_ins];

endmodule
