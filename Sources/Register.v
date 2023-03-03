
module Register_Module(
input   [4:0] addr_OP_1, addr_OP_2,
input   Reg_Write_En,Reg_Read_en,
output  [31:0]OP_1,OP_2,
input clk,reset,

input [31:0] Result_to_Register,
input [4:0]  Result_Addr
);

reg [31:0] Reg_Bank [31:0];
integer i;
      
assign OP_1 =  Reg_Bank[addr_OP_1] ;  
assign OP_2 =  Reg_Bank[addr_OP_2] ;  

always @(negedge clk) begin
         if(reset == 0) begin  
            if(Reg_Write_En == 1'b1) begin
                Reg_Bank[Result_Addr] <= Result_to_Register;
            end  end
          else begin
                  for (i = 4 ; i<=31 ; i = i+1) begin
                    Reg_Bank[i] <= 0;
                end  
                    Reg_Bank[0] <= 0;
                    Reg_Bank[1] <= 0;
                    Reg_Bank[2] <= 32'h7fffeffc; 
                    Reg_Bank[3] <= 32'h10008000; 
          end
end


              
endmodule