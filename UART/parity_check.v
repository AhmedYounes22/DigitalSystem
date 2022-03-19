module parity_check (
input wire CLK, RST,
input  wire [7:0]     P_DATA,
input  wire		  parity,
input wire dont_latch,
output reg            parity_out
);

reg [7:0] P_DATA_reg;

always @(posedge CLK or negedge RST)
 begin
 if (!RST)
   begin
    P_DATA_reg <= 'b0;
	parity_out <= 1'b0;
   end
 else if (!dont_latch)
	begin
		P_DATA_reg <= P_DATA;
	end
 else 
 begin
  if (parity == 1'b1)
   begin
    parity_out <= ~^P_DATA_reg; // odd parity check
   end
  else
   begin
    parity_out <= ^P_DATA_reg; // even parity check    
   end
  end
 end

endmodule

