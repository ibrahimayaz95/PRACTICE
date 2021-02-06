//This is I2C SDA LINE TOP MODULE
module SDA_Top
(
input logic i_clk, i_reset	//Clock and Reset inputs
);
wire io_sda;			//SDA line switch

SDA_Master Unit_1(.i_clk(i_clk), .i_reset(i_reset), .io_sda(io_sda));
SDA_Slave Unit_2(.i_clk(i_clk), .i_reset(i_reset), .io_sda(io_sda));

endmodule