`timescale 1ns / 1ps


module CPU_Wrapper #(parameter Memory_Size = 152)    (input clk,reset);

wire [31:0] INSTURCTION;
wire [31:0] Current_pc,Updated_pc;
wire [6:0] opcode;

wire [3:0] Alu_Sel;
wire [2:0] Alu_Sel_B;
wire Pc_manipulation,Imm_Gen_Signal,Pc_Manipulate_Alu;
wire [4:0] Reg_Write_Addr;

wire [31:0] RegOP_1, RegOP_2, OP_2 , Imm_Val;
wire Reg_Read_en,Register_Write_En;
wire [31:0] ALU_RES;
wire Extract ,Store  ; 

wire [31:0] Extract_Value;

wire [4:0]  Reg_Op_1_Addr , Reg_Op_2_Addr;
wire [2:0] Func_3;

Instruction_Decoder Instruction_Decoder(
.INSTURCTION             (INSTURCTION)        ,
.opcode                  (opcode )            ,
.Alu_Sel                 (Alu_Sel)             ,
.Alu_Sel_B               (Alu_Sel_B)           , 
.Register_Write_En       (Register_Write_En)   ,
.Reg_Read_en             (Reg_Read_en)              ,
.Imm_Gen_Signal          (Imm_Gen_Signal)           ,
.Pc_manipulation         (Pc_manipulation)          ,

.Reg_Op_1_Addr            (Reg_Op_1_Addr)            ,  
.Reg_Op_2_Addr            (Reg_Op_2_Addr)            ,
.Reg_Write_Addr           (Reg_Write_Addr)           ,
.B_ins_signal             (B_ins_signal)             ,

.MEM_Extract          (Extract),
.MEM_Store            (Store),
.Func_3                (Func_3)
);    

Program_Counter Program_Counter(
.clk          (clk)     ,
.reset        (reset)     ,
.PC_Updated   (Updated_pc)     ,
.PC_Current   (Current_pc)
);

Instruction_Memory Instruction_Memory(
.INSTRUCTION(INSTURCTION),
.PC(Current_pc)
 );

PC_Alu PC_Alu(
.PC_Alu_OP                 (Imm_Val)            ,
.Current_PC                (Current_pc)         ,
.Updated_PC                (Updated_pc)         ,
.Pc_Manipulate_Encoder     (Pc_manipulation)    ,
.Pc_Manipulate_Alu         (Pc_Manipulate_Alu)  ,
.Branch_ins                (B_ins_signal)
    );
    
wire zero,overflow ,OP_1_Bigger,Equal;
   
Alu Alu (
.Alu_Sel            (Alu_Sel   )          ,
.Alu_Sel_B          (Alu_Sel_B )          ,
.Pc_Manipulate      (Pc_manipulation)     ,
.OP_1               (RegOP_1)             ,
.OP_2               (OP_2)                ,
.Result             (ALU_RES)             ,
.Zero               (Zero       )         ,
.Overflow           (Overflow   )         ,
.OP_1_Bigger        (OP_1_Bigger)         ,
.Equal              (Equal      )         ,
.Pc_Manipulate_Alu  (Pc_Manipulate_Alu)          
);
    
    
ALU_OP_Selector ALU_OP_Selector(
.opcode     (opcode)        ,
.Reg_2      (RegOP_2)       , 
.Imm_Val    (Imm_Val)       ,
.OP         (OP_2)
    );

wire [31:0] Store_big_mem;   
Big_Memory #(.Memory_Size(Memory_Size))  Big_Memory    
( 
.reset            (reset)                 ,
.clk              (clk)                   , 
.Store_Addr       (ALU_RES)               ,
.Extract_Addr     (ALU_RES)               ,
.Extract          (Extract)               ,
.Store            (Store)                 ,
.Extract_Value    (Extract_Value)         ,
.Store_Value      (RegOP_2),
.func_3 (Func_3)
);

Imm_Gen Imm_Gen(
.Imm_Gen_Signal   (Imm_Gen_Signal )              ,
.Instruction      (INSTURCTION    )              ,
.opcode           (opcode         )              ,
.IMM_VAL          (Imm_Val        )              
);

wire [31:0] Result_to_Register;
assign Result_to_Register = (Extract == 1'b1)       ? Extract_Value : 
                            (opcode == `U_ins_lui ) ? Imm_Val:
                            ALU_RES ;
                            
//Register input can come from
//      1- Alu      2-Memory        3-PC_ALU        4-Immidate_Gen


//assign  Store_big_mem = () ? :  ;

Register_Module Register_Module(
.addr_OP_1             (Reg_Op_1_Addr)              , 
.addr_OP_2             (Reg_Op_2_Addr)              ,
.Reg_Write_En          (Register_Write_En)          ,
.Reg_Read_en           (Reg_Read_en)                ,
.OP_1                  (RegOP_1)                    ,
.OP_2                  (RegOP_2)                    ,
.clk                   (clk)                        ,
.reset                 (reset)                      ,
.Result_to_Register    ( Result_to_Register   )     ,
.Result_Addr           (Reg_Write_Addr)
);





endmodule