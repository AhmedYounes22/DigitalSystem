module UART_TOP (
input  wire       CLK,RST,
input  wire [7:0] P_DATA,
input  wire	   PAR_TYPE, PAR_ENABLE,
input  wire       DATA_VALID,
output wire  	   S_DATA,BUSY
);

//internal wires

wire [1:0]		SEL;
wire 		 	parity_out;
wire				parity;
wire 			ser_out;
wire 			ser_done;
wire 			send;
wire 			load;
wire 			dont_latch;

FSM U0 (
.DATA_VALID(DATA_VALID),
.send (send),
.ser_done (ser_done),
.PAR_TYPE(PAR_TYPE),
.PAR_ENABLE(PAR_ENABLE),
.BUSY (BUSY),
.SEL(SEL),
.CLK (CLK),
.RST (RST),
.parity(parity),
.load (load),
.dont_latch(dont_latch)
);

serializer U1 (
.P_DATA (P_DATA),
.send (send),
.ser_done(ser_done),
.ser_out(ser_out),
.CLK (CLK),
.RST (RST),
.dont_latch (dont_latch),
.load (load)
);

parity_check U2 (
.CLK (CLK),
.RST (RST),
.P_DATA (P_DATA),
.parity_out (parity_out),
.parity(parity),
.dont_latch (dont_latch)
);

MUX U3 (
.ser_out (ser_out),
.SEL (SEL),
.parity_out (parity_out),
.S_DATA (S_DATA)
);

endmodule

