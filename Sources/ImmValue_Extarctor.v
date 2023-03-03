`include "Instruction_Types.vh"

module Imm_Gen(
input   Imm_Gen_Signal,
input   [31:0] Instruction,
input   [6:0]opcode,
output  [31:0] IMM_VAL
);

wire imm_init_sign;
wire [17:0] U_imm_init; 
wire [6:0]  S_imm_init_big ;     wire [4:0] S_imm_init_small;       wire [19:0] S_imm_sign_extend;
wire [11:0] I_imm_init;          wire [19:0]I_imm_sign_extend;
wire [18:0] J_imm_init;          wire [10:0] J_imm_sign_extend ;
wire [5:0]  B_imm_init_big;      wire [4:0]B_imm_init_small;        wire [18:0] B_imm_sign_extend;

assign imm_init_sign  = Instruction [31];

assign U_imm_init     = Instruction [30:12] ;
assign S_imm_init_big = Instruction [31:25] ;     assign S_imm_init_small = Instruction [11:7];
assign B_imm_init_big = Instruction [30:25] ;     assign B_imm_init_small = Instruction [11:7] ;
assign I_imm_init     = Instruction [31:20] ; 
assign J_imm_init     = Instruction [30:12] ;

assign I_imm_sign_extend =  (imm_init_sign == 1'b1) ? 20'b11111111111111111111  : 20'b000000000000000000000 ;
assign S_imm_sign_extend =  (imm_init_sign == 1'b1) ? 20'b11111111111111111111  : 20'b000000000000000000000 ;
assign B_imm_sign_extend =  (imm_init_sign == 1'b1) ? 19'b1111111111111111111   : 19'b00000000000000000000 ;
assign J_imm_sign_extend =  (imm_init_sign == 1'b1) ? 11'b11111111111           : 11'b00000000000 ;


assign IMM_VAL = (Imm_Gen_Signal == 1'b1) & ( (opcode == `I_ins_L) | (opcode == `I_ins_J) | (opcode == `I_ins_R) )  ? {I_imm_sign_extend,I_imm_init } :
                 (Imm_Gen_Signal == 1'b1) & (opcode == `S_ins) ? {S_imm_sign_extend,S_imm_init_big,S_imm_init_small } :
                 (Imm_Gen_Signal == 1'b1) & (opcode == `B_ins) ? {B_imm_sign_extend,imm_init_sign ,B_imm_init_small[0],B_imm_init_big,B_imm_init_small[4:1],1'b0 } :
                 (Imm_Gen_Signal == 1'b1) & (opcode == `J_ins) ? {J_imm_sign_extend,imm_init_sign,J_imm_init[7:0],J_imm_init[8],J_imm_init[18:9],1'b0}:
                 0;
                          

endmodule
