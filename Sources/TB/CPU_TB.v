module CPU_TB #(parameter Memory_Size = 152, parameter clk_per =40)
();

reg reset = 1; reg clk = 0; always #(clk_per/2) clk <= ~clk;

CPU_Wrapper #(.Memory_Size(Memory_Size))  CPU (.clk(clk), .reset(reset));


initial begin

#80 reset <= 0;

end

endmodule