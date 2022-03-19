//`timescale 1us/1ns
module CLKDIV_tb ();

//TEST BENCH SIGNALS
reg i_ref_clk_tb=0;
reg i_rst_tb=1;
reg i_clk_en_tb=0;
reg [3:0] i_div_ratio_tb=0;
wire o_div_clk_tb ;

// parameters
parameter  CLK_PERIOD = 5 ; 


initial
  begin
    $dumpfile("CLKDIV.vcd");
    $dumpvars ;
	#CLK_PERIOD i_rst_tb = 1'b0;
	#CLK_PERIOD i_rst_tb = 1'b1;

	i_div_ratio_tb = 4'b0100;
	i_clk_en_tb = 1'b1;

#100 $finish;  //finished with simulation 
  end


// Clock Generator with 200 MHz (5 ns)
  always  #(CLK_PERIOD/2) i_ref_clk_tb = ~i_ref_clk_tb;  
 

CLKDIV DUT (
. i_ref_clk( i_ref_clk_tb),
. i_rst ( i_rst_tb),
.i_clk_en (i_clk_en_tb),
.i_div_ratio (i_div_ratio_tb),
.o_div_clk (o_div_clk_tb )
);

endmodule
