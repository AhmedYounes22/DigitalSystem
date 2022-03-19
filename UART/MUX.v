module MUX (
input  wire	[1:0]   SEL,
input  wire            ser_out,
input  wire 	        parity_out,
output reg 		   S_DATA
);

localparam  [1:0] 	  START = 2'b00,
				  SEND = 2'b01,
				  PARITY = 2'b11,
				  STOP = 2'b10;

always @(*)
 begin
  case (SEL)
    START: 	 begin
			  S_DATA = 1'b0;
			 end
		   
    SEND: 	 begin
			  S_DATA = ser_out;
		      end
		   
    PARITY:     begin
			  S_DATA = parity_out;
		      end
		   
    STOP: 	 begin
			  S_DATA = 1'b1;
		      end

   endcase
 end
 
endmodule
