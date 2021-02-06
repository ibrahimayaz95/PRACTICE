module SDA_Testbench();

logic i_clk, i_reset;

SDA_Top Unit_Under_Test(.i_clk(i_clk), .i_reset(i_reset));

initial
	begin
	i_clk = 1'b0;
	i_reset = 1'b0;
	#5;
	i_reset = 1'b1;
	#20;
	i_reset = 1'b0;
	end
	
initial
	begin
		forever #10 i_clk = ~i_clk;
	end

initial
	begin
		#100 $finish();
	end
	
endmodule