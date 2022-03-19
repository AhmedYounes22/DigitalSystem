module CLKDIV #( 
 parameter DIV_WIDTH = 8 
)
(
 input  wire                   		 i_ref_clk ,             // Reference clock
 input  wire                  		 i_rst ,                 // Reset Signal
 input  wire                        	 i_clk_en,               // clock divider enable
 input  wire [DIV_WIDTH - 1 : 0]         i_div_ratio,            // clock division ratio
 output wire                  	      o_div_clk               // Divided clock
);

reg [DIV_WIDTH - 1 : 0]   counter;
reg					 div_clk; 
wire 				 is_one, is_zero, clock_enable;

always @(posedge i_ref_clk or negedge i_rst)
 begin
  if (!i_rst)
   begin
     div_clk <= 1'b0;
	counter <= 1'b0;
   end
  else 
   begin
    if ( clock_enable && i_div_ratio[0] == 4'b0)  //even division condition
	begin
	 if ( counter == (i_div_ratio >> 1) - 1)
	  begin
	   div_clk <= ~div_clk;
	   counter <= 4'b0;
	  end
	  else
	  begin
	   counter <= counter + 4'b1;
	  end
	end
	else if ( clock_enable && i_div_ratio[0] == 4'b1) //odd division condition
	begin
	 if ( counter == ((i_div_ratio + 1'b1) >> 1) - 1'b1) //to get the first part of the period
	  begin
	   div_clk <= ~div_clk ;
	   counter <= counter + 4'b1;
	  end
       else if ( counter == i_div_ratio - 1'b1 ) //to get the second part of the period
	   begin
	   div_clk <= ~div_clk ;
	   counter <= 4'b0;
        end
	  else 
	  begin
	   counter <= counter + 4'b1;
	  end
	end
   end
 end

assign is_zero = (i_div_ratio == 1'b0); //to check that we don't divide by 0
assign is_one = (i_div_ratio == 1'b1); //to check that we don't enter the same clock
assign clock_enable = i_clk_en & !is_one & !is_zero;
assign o_div_clk =  clock_enable ? div_clk : i_ref_clk ; 
endmodule
