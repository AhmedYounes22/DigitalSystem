module FSM (
input  wire	       CLK, RST,
input  wire	  	   DATA_VALID,
input  wire		   ser_done,
input  wire		   PAR_TYPE, PAR_ENABLE,
output reg	  	   BUSY,send,load,
output reg         parity,
output reg	[1:0]  SEL,
output reg 		   dont_latch	
);

localparam  [2:0]     IDLE = 3'b000,
				  START = 3'b001,
				  SEND = 3'b011,
				  PARITY = 3'b010,
				  STOP = 3'b110;
				  
reg    [2:0]      current_state,
                  next_state ;

// state transition
always @(posedge CLK or negedge RST)
 begin
  if(!RST)
   begin
    current_state <= IDLE;
   end
  else
   begin
	current_state <= next_state;
   end   
 end 
 
// next state logic
always @ (*)
 begin
 BUSY = 1'b0;
 load = 1'b0;
 send = 1'b0;
 dont_latch = 1'b1;
  case (current_state)
   IDLE : 		begin
				 if ( DATA_VALID == 1'b1 )
				  begin 
				   BUSY = 1'b1;
				   load = 1'b1;
				   next_state = START;
				   dont_latch = 1'b0;
				   parity = PAR_TYPE;
				  end
				 else
				  begin
				   SEL = 2'b10;
				   next_state = IDLE;
			     end
				end
		  
   START : 		begin
				 BUSY = 1'b1;
				 SEL = 2'b00;
				 send = 1'b0;
				 load = 1'b0;
				 //dont_latch = 1'b0;
				 next_state = SEND;
				end
		  
   SEND : 		begin
				 
				 send = 1'b1;
				 BUSY = 1'b1;
				 SEL = 2'b01;
				 if( ser_done == 1)
				  begin
				   if ( PAR_ENABLE == 1 )
				    begin
				     next_state = PARITY;
				    end
				   else
				    next_state = STOP;
				 end
				else 
				 begin
				  next_state = SEND;
				 end
				end
		  
   PARITY : 	begin
				 SEL = 2'b11;
				 BUSY = 1'b1;
				 //parity = PAR_TYPE;
				 next_state = STOP;
		        end
				
   STOP: 		begin
				 SEL = 2'b10;
				 BUSY = 1'b1;
				 next_state = IDLE;
				end
				
   default : 	begin
				 next_state = IDLE;
				 BUSY = 1'b0;
				end		  
  
  endcase
 end
 
endmodule

