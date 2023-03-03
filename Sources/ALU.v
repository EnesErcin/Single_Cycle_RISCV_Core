`include "Instruction_Types.vh"

module Alu(
input  [3:0]Alu_Sel,
input  [2:0]Alu_Sel_B,
input  Pc_Manipulate,

input  [31:0] OP_1,OP_2,
output [31:0]Result,
output Zero,Overflow,
output OP_1_Bigger,Equal,Pc_Manipulate_Alu
);

// $signed(OP_1) < $signed(OP_2)
wire is_equal ;

wire signed [31:0] OP_1_signed;

//wire [7:0] Store_Byte;           assign         Store_Byte          =     OP_2[];
//wire [15:0]Store_HalfWord;       assign         Store_HalfWord      =     OP_2[];

assign Result  = (Alu_Sel ==  `ADD  )  ? 	OP_1 + OP_2                 : 
				 (Alu_Sel ==  `SUB  )  ?	OP_1 - OP_2                 :
				 (Alu_Sel ==  `SLL  )  ?  OP_1 << OP_2                :
                 (Alu_Sel ==  `SLTU )  & (!is_equal) & (OP_1 < OP_2 )?     
                                               OP_1                   :
                 (Alu_Sel ==  `SLTU )  & (!is_equal) & (OP_1 > OP_2 )?     
                                            OP_2                       :                                      
                 (Alu_Sel ==  `SRA  )  ?    OP_1_signed >>>   OP_2     :
                 (Alu_Sel ==  `OR   )  ?    OP_1|OP_2                  :
                 (Alu_Sel ==  `AND  )  ?    OP_1&OP_2                  :
                 (Alu_Sel ==  `XOR  )  ?    OP_1^OP_2                  :
                 (Alu_Sel ==  `SRL  )  ?    OP_1 >>   OP_2             :
                  0
                 ;


assign OP_1_Bigger_U = ($signed(OP_1) > $signed(OP_2))  ? 1'b1 : 1'b0;
assign OP_1_Bigger   = (OP_1 > OP_2)  ? 1'b1 : 1'b0;
assign Equal         = (OP_1 == OP_2) ? 1'b1 : 1'b0;

assign Pc_Manipulate_Alu =   (Alu_Sel_B == `BEQ ) &   (Equal == 1'b1) ?          1'b1:
                             (Alu_Sel_B == `BEQ ) &   (Equal == 1'b0) ?          1'b0:
                             (Alu_Sel_B ==  `BNE  ) &   (Equal == 1'b0) ?          1'b1:                 
                             (Alu_Sel_B ==  `BNE  ) &   (Equal == 1'b1) ?          1'b0:
                             
				             (Alu_Sel_B ==  `BLT  ) & ( OP_1_Bigger == 1'b0) ?	1'b1:
				             (Alu_Sel_B ==  `BLT  ) & ( OP_1_Bigger == 1'b1) ?	1'b0:
				             
				             
				             (Alu_Sel_B ==  `BLTU )  & ( OP_1_Bigger_U == 1'b1) ?    1'b1:  
				             (Alu_Sel_B ==  `BLTU )  & ( OP_1_Bigger_U == 1'b1) ?    1'b0:  
				             
				             (Alu_Sel_B ==  `BGE  )  & ( OP_1_Bigger == 1'b1) ?      1'b1:
				             (Alu_Sel_B ==  `BGE  )  & ( OP_1_Bigger == 1'b0) ?      1'b0:
                               
				             (Alu_Sel_B  ==  `BGEU  )  & ( OP_1_Bigger_U == 1'b1) ?      1'b1:
				             (Alu_Sel_B  ==  `BGEU  )  & ( OP_1_Bigger_U == 1'b0) ?      1'b0:                                    
                             1'bx;
    

endmodule