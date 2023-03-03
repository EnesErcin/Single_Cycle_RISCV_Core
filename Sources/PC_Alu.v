`timescale 1ns / 1ps


module PC_Alu(
input [31:0] PC_Alu_OP,
input [31:0] Current_PC,
output[31:0] Updated_PC,
input Pc_Manipulate_Encoder,Pc_Manipulate_Alu,Branch_ins
    );
    
    
assign Updated_PC = (Pc_Manipulate_Encoder == 1'b0) ?  ( Current_PC + 4 )                                                               : 
                    (Pc_Manipulate_Encoder == 1'b1) &  (Branch_ins == 1'b0) ?  ( Current_PC + PC_Alu_OP )                               :
                    (Pc_Manipulate_Encoder == 1'b1) &  (Branch_ins == 1'b1) & (Pc_Manipulate_Alu == 1'b1) ?  ( Current_PC + PC_Alu_OP ) :
                    (Pc_Manipulate_Encoder == 1'b1) &  (Branch_ins == 1'b1) & (Pc_Manipulate_Alu == 1'b0) ?  ( Current_PC + 4 )         :
                    32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
                    
                    
    
endmodule
