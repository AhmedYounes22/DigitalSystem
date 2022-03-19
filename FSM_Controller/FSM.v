module FSM_Controller #(parameter WIDTH = 8 , ALU_FUN_WD = 4)(

input    wire                  CLK,
input    wire                  RST,
input    wire                  Enable,
input    wire [WIDTH-1:0]      ALU_Config0,
input    wire [WIDTH-1:0]      ALU_Config1,
input    wire                  UART_Busy,
output   reg  [ALU_FUN_WD-1:0] ALU_FUN,
output   reg                   ALU_Enable,
output   reg                   CLKG_EN
);

parameter 	[4:0] 	IDLE = 5'b00000,
					CHK_ADD = 5'b00001,
					CHK_SUB = 5'b00010,
					CHK_MUL = 5'b00011,
					CHK_DIV = 5'b00100,
					CHK_AND = 5'b00101,
					CHK_OR = 5'b00110,
					CHK_NAND = 5'b00111,
					CHK_NOR = 5'b01000,
					CHK_XOR = 5'b01001,
					CHK_XNOR = 5'b01010,
					CHK_EQ = 5'b01011,
					CHK_GR = 5'b01100,
					CHK_LS = 5'b01101,
					CHK_SFT_R = 5'b01110,
					CHK_SFT_L = 5'b01111,
					CHK_NO_OP = 5'b10000,
					WAIT_BUSY = 5'b10001;
			

reg [4:0] 	next_state,
			current_state,
			temp_state;
			
// state transition
always @(posedge CLK or negedge RST)
 begin
  if(!RST)
   begin
	current_state <= IDLE;
	temp_state <= IDLE;
   end
  else
   begin
	current_state <= next_state;
   end
 end
 
// next state logic 
always @(*)
 begin
	CLKG_EN = 1'b1;
	ALU_FUN = 'b0000;
	ALU_Enable = 1'b0;
	case (current_state)
	IDLE	:	begin
					if (Enable)
						begin
							next_state = CHK_ADD;
						end
					else
						begin
							next_state = IDLE;
						end
				end
				
	CHK_ADD	:	begin
					if (ALU_Config0[0])
						begin
							ALU_Enable = 1'b1;
							ALU_FUN = 'd0;
							next_state = WAIT_BUSY;
							temp_state = CHK_SUB;
						end
					else 
						begin
							next_state = CHK_SUB;
							ALU_Enable = 0;
						end
				end				
				
	CHK_SUB	:	begin
					if (ALU_Config0[1])
						begin
							ALU_Enable = 1'b1;
							ALU_FUN = 'd1;
							next_state = WAIT_BUSY;
							temp_state = CHK_MUL;
						end
					else 
						begin
							next_state = CHK_MUL;
							ALU_Enable = 0;
						end
				
				end
				
	CHK_MUL	:	begin
					if (ALU_Config0[2])
						begin
							ALU_Enable = 1'b1;
							ALU_FUN = 'd2;
							next_state = WAIT_BUSY;
							temp_state = CHK_DIV;
						end
					else 
						begin
							next_state = CHK_DIV;
							ALU_Enable = 0;
						end
				
				end
				
	CHK_DIV	:	begin
					if (ALU_Config0[3])
						begin
							ALU_Enable = 1'b1;
							ALU_FUN = 'd3;
							next_state = WAIT_BUSY;
							temp_state = CHK_AND;
						end
					else 
						begin
							next_state = CHK_AND;
							ALU_Enable = 0;
						end
				
				end
				
	CHK_AND	:	begin
					if (ALU_Config0[4])
						begin
							ALU_Enable = 1'b1;
							ALU_FUN = 'd4;
							next_state = WAIT_BUSY;
							temp_state = CHK_OR;
						end
					else 
						begin
							next_state = CHK_OR;
							ALU_Enable = 0;
						end
				
				end
				
	CHK_OR	:	begin
					if (ALU_Config0[5])
						begin
							ALU_Enable = 1'b1;
							ALU_FUN = 'd5;
							next_state = WAIT_BUSY;
							temp_state = CHK_NAND;
						end
					else 
						begin
							next_state = CHK_NAND;
							ALU_Enable = 0;
						end
				
				end
				
	CHK_NAND:	begin
					if (ALU_Config0[6])
						begin
							ALU_Enable = 1'b1;
							ALU_FUN = 'd6;
							next_state = WAIT_BUSY;
							temp_state = CHK_NOR;
						end
					else 
						begin
							next_state = CHK_NOR;
							ALU_Enable = 0;
						end
				
				end
				
	CHK_NOR	:	begin
					if (ALU_Config0[7])
						begin
							ALU_Enable = 1'b1;
							ALU_FUN = 'd7;
							next_state = WAIT_BUSY;
							temp_state = CHK_XOR;
						end
					else 
						begin
							next_state = CHK_XOR;
							ALU_Enable = 0;
						end
				
				end
				
	CHK_XOR	:	begin
					if (ALU_Config1[0])
						begin
							ALU_Enable = 1'b1;
							ALU_FUN = 'd8;
							next_state = WAIT_BUSY;
							temp_state = CHK_XNOR;
						end
					else 
						begin
							next_state = CHK_XNOR;
							ALU_Enable = 0;
						end
				
				end
				
	CHK_XNOR:	begin
					if (ALU_Config1[1])
						begin
							ALU_Enable = 1'b1;
							ALU_FUN = 'd9;
							next_state = WAIT_BUSY;
							temp_state = CHK_EQ;
						end
					else 
						begin
							next_state = CHK_EQ;
							ALU_Enable = 0;
						end
				
				end
				
	CHK_EQ	:	begin
					if (ALU_Config1[2])
						begin
							ALU_Enable = 1'b1;
							ALU_FUN = 'd10;
							next_state = WAIT_BUSY;
							temp_state = CHK_GR;
						end
					else 
						begin
							next_state = CHK_GR;
							ALU_Enable = 0;
						end
				
				end
				
	CHK_GR	:	begin
					if (ALU_Config1[3])
						begin
							ALU_Enable = 1'b1;
							ALU_FUN = 'd11;
							next_state = WAIT_BUSY;
							temp_state = CHK_LS;
						end
					else 
						begin
							next_state = CHK_LS;
							ALU_Enable = 0;
						end
				
				end
				
	CHK_LS	:	begin
					if (ALU_Config1[4])
						begin
							ALU_Enable = 1'b1;
							ALU_FUN = 'd12;
							next_state = WAIT_BUSY;
							temp_state = CHK_SFT_R;
						end
					else 
						begin
							next_state = CHK_SFT_R;
							ALU_Enable = 0;
						end
				
				end
				
	CHK_SFT_R:	begin
					if (ALU_Config1[5])
						begin
							ALU_Enable = 1'b1;
							ALU_FUN = 'd13;
							next_state = WAIT_BUSY;
							temp_state = CHK_SFT_L;
						end
					else 
						begin
							next_state = CHK_SFT_L;
							ALU_Enable = 0;
						end
				
				end
				
	CHK_SFT_L:	begin
					if (ALU_Config1[6])
						begin
							ALU_Enable = 1'b1;
							ALU_FUN = 'd14;
							next_state = WAIT_BUSY;
							temp_state = CHK_NO_OP;
						end
					else 
						begin
							next_state = CHK_NO_OP;
							ALU_Enable = 0;
						end
					
				end
				
	CHK_NO_OP:	begin
					if (ALU_Config1[7])
						begin
							ALU_Enable = 1'b1;
							ALU_FUN = 'd15;
							next_state = WAIT_BUSY;
							temp_state = IDLE;
						end
					else 
						begin
							next_state = CHK_XNOR;
							ALU_Enable = 0;
						end
				
				end
				
	WAIT_BUSY:	begin
				 if(UART_Busy)
					begin
						next_state = WAIT_BUSY;
					end
				else
					begin
						next_state = temp_state;
					end
				
				end
				

	default	:	begin
					next_state = IDLE;
				end	
	
	endcase
 end

// output logic
/*always @(*)
 begin
	case (current_state)
	IDLE	:	begin
	
				
				end
				
	CHK_ADD	:	begin
	
				
				end				
				
	CHK_SUB	:	begin
	
				
				end
				
	CHK_MUL	:	begin
	
				
				end
				
	CHK_DIV	:	begin
	
				
				end
				
	CHK_AND	:	begin
	
				
				end
				
	CHK_OR	:	begin
	
				
				end
				
	CHK_NAND:	begin
	
				
				end
				
	CHK_NOR	:	begin
	
				
				end
				
	CHK_XOR	:	begin
	
				
				end
				
	CHK_XNOR:	begin
	
				
				end
				
	CHK_EQ	:	begin
	
				
				end
				
	CHK_GR	:	begin
	
				
				end
				
	CHK_LS	:	begin
	
				
				end
				
	CHK_SFT_R:	begin
	
				
				end
				
	CHK_SFT_L:	begin
	
				
				end
				
	CHK_NO_OP:	begin
	
				
				end
				
	WAIT_BUSY:	begin
	
				
				end
				
	IDLE	:	begin
	
				
				end

	default	:	begin
					
				end	
	
	endcase
 end

*/
endmodule
 