//This is I2C MASTER SDA LINE MODULE
module SDA_Master
(
input logic i_clk, i_reset,	//Clock and Reset inputs
inout tri io_sda			//SDA line switch
);
logic enable;				//Enable signal
logic sda_master_read;		//Data Read
logic sda_in;				//tri type decleration activator signal

enum {master_drive,master_sample,idle} present_state_master, next_state_master;

assign io_sda = enable ? sda_in : 1'bz; //If enable signal gets 1, io_sda switch will gets sda_in signal or open circuit

always@(posedge i_clk or posedge i_reset)
	begin
		if(i_reset)
			begin
				present_state_master = idle;
			end
		else
			begin
				present_state_master = next_state_master;
			end
	end

always@(*)
	begin
		case(present_state_master)
			idle:
				begin
					next_state_master = master_drive;
				end
			master_drive:
				begin
					enable = 1'b1;
					sda_in = 1'b1;
					next_state_master = master_sample;
				end
			master_sample:
				begin
					enable = 1'b0;
					#0 sda_master_read = io_sda;
					next_state_master = idle;
					$display("Value of sda driven by slave and sampled by master = %0b at %0t ", sda_master_read, $realtime);
				end
		endcase	
	end
endmodule