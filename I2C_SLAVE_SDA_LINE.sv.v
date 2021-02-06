//This is I2C SLAVE SDA LINE MODULE
module SDA_Slave
(
input logic i_clk, i_reset,	//Clock and Reset inputs
inout tri io_sda			//SDA line switch
);
logic enable;				//Enable signal
logic sda_slave_read;		//Data Read
logic sda_in;				//tri type decleration activator signal

  enum {slave_sample, slave_drive, idle} present_state_slave, next_state_slave;

assign io_sda = enable ? sda_in : 1'bz; //If enable signal gets 1, io_sda switch will gets sda_in signal or open circuit

always@(posedge i_clk or posedge i_reset)
	begin
		if(i_reset)
			begin
				present_state_slave = idle;
				end
		else
			begin
				present_state_slave = next_state_slave;
			end	
	end

always@(*)
	begin
		case(present_state_slave)
			idle:
				begin
					next_state_slave = slave_sample;
				end
			slave_sample:
				begin
					enable = 1'b0;
					next_state_slave = slave_drive;
					#0 sda_slave_read = io_sda;
					$display("Value of sda driven by master and sampled by slave = %0b at %0t",sda_slave_read, $realtime);
				end
			slave_drive:
				begin
					enable = 1'b1;
					sda_in = 1'b0;
					next_state_slave = idle;
				end
		endcase	
	end
endmodule
