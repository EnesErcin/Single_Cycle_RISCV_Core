`include "Instruction_Types.vh"

module Instruction_Decoder(
input           [31:0]INSTURCTION,

output 	wire	[6:0] 	opcode,

output 			[3:0] 	Alu_Sel,
output          [2:0]   Alu_Sel_B,
output 			Register_Write_En,Imm_Gen_Signal,Reg_Read_en,B_ins_signal,
output          Pc_manipulation,

output          [4:0]Reg_Op_1_Addr,Reg_Op_2_Addr,Reg_Write_Addr ,
output          MEM_Extract,MEM_Store,
output          [2:0]	Func_3
);
assign      Func_3 = INSTURCTION[14:12] ; 
wire 	      [6:0]	Func_7 ;     assign      Func_7 = INSTURCTION[31:25] ;

assign opcode = INSTURCTION[6:0];

wire  R_ins_signal, J_ins_signal,I_ins_signal ;
assign R_ins_signal = (opcode == `R_ins) ?  1'b1 : 1'b0; 
assign B_ins_signal = (opcode == `B_ins) ?  1'b1 : 1'b0; 
assign J_ins_signal = (opcode == `J_ins) ?  1'b1 : 1'b0; 
assign I_ins_signal = ( (opcode == `I_ins_L) | (opcode == `I_ins_J) | (opcode == `I_ins_R) )?  1'b1 : 1'b0; 
assign S_ins_signal = (opcode == `S_ins) ?  1'b1 : 1'b0; 
assign U_ins_signal = (opcode == `U_ins_lui ) | (opcode == `U_ins_auipc  )?  1'b1 : 1'b0; 


assign Alu_Sel   = ( R_ins_signal  == 1)  &  (Func_3 == 3'b000 )  & (Func_7[5] == 1'b0) ?   `ADD  : 
				   ( R_ins_signal  == 1)  &  (Func_3 == 3'b000 )  & (Func_7[5] == 1'b1) ?	`SUB  :
				   ( R_ins_signal  == 1)  &  (Func_3 == 3'b001 )  ?                         `SLL  :
                   ( R_ins_signal  == 1)  &  (Func_3 == 3'b010 )  ?                         `SLT  :
                   ( R_ins_signal  == 1)  &  (Func_3 == 3'b011 )  ?   				 	    `SLTU :
                   ( R_ins_signal  == 1)  &  (Func_3 == 3'b100 )  ? 		                `XOR  :
                   ( R_ins_signal  == 1)  &  (Func_3 == 3'b101 )  & (Func_7[5] == 1'b0)?    `SRL  :
                   ( R_ins_signal  == 1)  &  (Func_3 == 3'b101 )  & (Func_7[5] == 1'b1)?    `SRA  :
                   ( R_ins_signal  == 1)  &  (Func_3 == 3'b110 )  ? 		                `OR   :
                   ( R_ins_signal  == 1)  &  (Func_3 == 3'b111 )  ? 		                `AND  :
                   
                   ( U_ins_signal  == 1)                          ? 		                `ADD  :
                   ( S_ins_signal  == 1)                          ?                         `ADD  : 
                   (opcode == `I_ins_L)                           ?                         `ADD  : 
                    

				   (opcode == `I_ins_R)  &  (Func_3 == 3'b000 )  ?                         `ADD  :
				   (opcode == `I_ins_R)  &  (Func_3 == 3'b010 )  ?                         `SLT  :
                   (opcode == `I_ins_R)  &  (Func_3 == 3'b011 )  ?                         `SLTU :
                   (opcode == `I_ins_R)  &  (Func_3 == 3'b100 )  ?   				 	   `XOR  :
                   (opcode == `I_ins_R)  &  (Func_3 == 3'b110 )  ? 		                   `OR   :
                   (opcode == `I_ins_R)  &  (Func_3 == 3'b111 )  ?                         `AND  :
                   (opcode == `I_ins_R)  &  (Func_3 == 3'b001 )  ?                         `SLL  :                   
                   (opcode == `I_ins_R)  &  (Func_3 == 3'b101 ) & (Func_7[5] == 1'b0)   ?  `SRL  :                     
                   (opcode == `I_ins_R)  &  (Func_3 == 3'b101 ) & (Func_7[5] == 1'b1)   ?  `SRA  :                    
                    
                   4'bxxx ;

assign Alu_Sel_B =                
                 ( B_ins_signal  == 1)  &  (Func_3 == 3'b000 )  ?                       `BEQ  : 
				 ( B_ins_signal  == 1)  &  (Func_3 == 3'b001 )  ?                   	`BNE  :
                 ( B_ins_signal  == 1)  &  (Func_3 == 3'b010 )  ?                       `BLT  :
                 ( B_ins_signal  == 1)  &  (Func_3 == 3'b011 )  ?   				 	`BGE  :
                 ( B_ins_signal  == 1)  &  (Func_3 == 3'b100 )  ? 		                `BLTU :
                 ( B_ins_signal  == 1)  &  (Func_3 == 3'b101 )  ?                       `BGEU :
                 ( B_ins_signal  == 1)  &  (Func_3 == 3'b111 )  ?                       `BGEU :                          
                  4'bxxx;
                  



wire jalr_ins ; assign jalr_ins = ((opcode == `I_ins_J) ) ? 1'b1 : 1'b0;
assign Pc_manipulation = (B_ins_signal | J_ins_signal | jalr_ins ) ?  1'b1 : 1'b0;

assign Imm_Gen_Signal = ( R_ins_signal == 1'b1) ? 1'b0 :1'b1 ;

assign Reg_Read_en       = (R_ins_signal == 1'b1) | (S_ins_signal == 1'b1) ? 1'b1 :  1'b0;
assign Register_Write_En = (B_ins_signal == 1'b1) | (S_ins_signal == 1'b1) ?  1'b0 :  1'b1;

assign        Reg_Op_1_Addr      = INSTURCTION[19:15];  
assign        Reg_Op_2_Addr      = INSTURCTION[24:20];
assign        Reg_Write_Addr     = INSTURCTION[11:7];

assign        MEM_Extract      = (opcode == `I_ins_L)   ? 1'b1:1'b0;
assign        MEM_Store        = (S_ins_signal == 1'b1) ? 1'b1:1'b0;

endmodule