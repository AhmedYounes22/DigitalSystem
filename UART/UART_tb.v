//`timescale 1us/1ns
module UART_tb ();

//TEST BENCH SIGNALS
 reg 	   CLK_tb =0, RST_tb=1;
 reg [7:0]   P_DATA_tb;
 reg  	   DATA_VALID_tb=0, PAR_ENABLE_tb=0, PAR_TYPE_tb=0;
 wire	   S_DATA_tb;
 wire 	   BUSY_tb;

// parameters
parameter  CLK_PERIOD = 5 ; 


initial
  begin
    $dumpfile("UART_TX.vcd");
    $dumpvars ;

//initial values
//CLK_tb = 1'b0;
#CLK_PERIOD RST_tb = 1'b0;
#CLK_PERIOD RST_tb = 1'b1;    

P_DATA_tb = 8'b10101011;

DATA_VALID_tb = 1'b0;    
PAR_TYPE_tb = 1'b0;
PAR_ENABLE_tb = 1'b0;

#CLK_PERIOD DATA_VALID_tb = 1'b1;    
#CLK_PERIOD DATA_VALID_tb = 1'b0;    

#100 $finish;  //finished with simulation 
  end


// Clock Generator with 200 MHz (5 ns)
  always  #(CLK_PERIOD/2) CLK_tb = ~CLK_tb;  
 

UART_TOP DUT (
.P_DATA (P_DATA_tb),
.DATA_VALID (DATA_VALID_tb),
.S_DATA (S_DATA_tb),
.BUSY (BUSY_tb),
.CLK (CLK_tb),
.RST (RST_tb),
.PAR_ENABLE (PAR_ENABLE_tb),
.PAR_TYPE (PAR_TYPE_tb)
);

endmodule
