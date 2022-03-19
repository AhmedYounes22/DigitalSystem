module serializer (
input  wire	       CLK, RST,
input  wire	[7:0]  P_DATA,
input  wire 	       load, send,
input wire 		  dont_latch,
output wire            ser_done,
output reg 		  ser_out
);

reg [7:0] P_DATA_REG ;
reg [3:0] counter_reg, counter ; 


always @ (posedge CLK or negedge RST)
begin
 if (!RST)
 begin
  counter_reg <= 4'b0000;
  ser_out <= 1'b0;
  end
 else if (load && !dont_latch)
  begin
   P_DATA_REG <= P_DATA;
  end

	counter_reg <= counter;
 end

always@(*) begin


if(send && counter_reg != 4'b1000)
  begin
   ser_out = P_DATA_REG [counter_reg];
   counter = counter_reg + 1;  
  end
else
	begin
	counter = 4'b0000 ;
	end


end
assign ser_done = (counter == 4'b1000);
endmodule
