
module Program_Counter(
input clk,reset,
input       [31:0] PC_Updated,
output reg  [31:0] PC_Current
);

always @(posedge clk) begin
    if(reset == 1'b0)
        PC_Current <= PC_Updated;
    else 
        PC_Current <= 32'b0;
end

endmodule