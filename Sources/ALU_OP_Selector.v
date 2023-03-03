`timescale 1ns / 1ps
`include "Instruction_Types.vh"

module ALU_OP_Selector(
input  [6:0] opcode,
input  [31:0] Reg_2, Imm_Val,
output [31:0] OP
    );
    
assign  OP = ( opcode == `R_ins) | ( opcode == `B_ins)  ? Reg_2: Imm_Val;  
    
endmodule
