`include "Instruction_Types.vh"

module Big_Memory #(parameter Memory_Size = 152)
(
input reset,clk,
input [6:0] Store_Addr,
input [6:0] Extract_Addr,
input  [2:0]func_3,
input  Extract,Store,
output [31:0] Extract_Value,
input  [31:0] Store_Value

);

wire [4:0] store_add; 
assign store_add = Store_Addr[6:2];
wire [2:0] store_loc; 
assign store_loc = Store_Addr[1:0];

reg [31:0] Mem_Bank [Memory_Size-1:0];

integer i ;


wire [15:0]half_word ; wire [7:0]byte_load ; 
assign half_word = Store_Value[15:0];
assign byte_load      = Store_Value[7:0];

assign Extract_Value = Mem_Bank[Extract_Addr];



always @(negedge clk) begin
    if(reset == 1'b0) begin
        if(Store   == 1'b1)
            case(func_3)
            `SB : begin
                    case(store_loc)
                        2'b00: Mem_Bank[store_add][7:0]    <=byte_load ;
                        2'b01: Mem_Bank[store_add][16:8]   <=byte_load ;
                        2'b10: Mem_Bank[store_add][25:17]  <=byte_load ;    
                        2'b11: Mem_Bank[store_add][31:26]  <=byte_load ;    
                    endcase
                   end
            `SH : begin
                    case(store_loc)
                        2'b00: Mem_Bank[store_add][15:0]  <= half_word;
                        2'b01: Mem_Bank[store_add][31:16] <= half_word;
                    endcase
                  end 
            `SW :  Mem_Bank[store_add] <= Store_Value;
            endcase
    end else begin
        for ( i = 0 ; i <= Memory_Size ; i = i + 1) begin
            Mem_Bank[i] <= 0;
        end
    end   
end

endmodule