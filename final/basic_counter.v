
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:08:36 11/11/2015 
// Design Name: 
// Module Name:    basic_counter 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module basic_counter(Y, trigger);
    input trigger;
	 output reg [15:0] Y;
	 
	 initial
	 Y = 0;
	 
	 always @ (posedge trigger)
		 if(Y[3:0] == 4'b1001)begin
			Y[3:0] = 0;
			Y[7:4] = Y[7:4] + 1'b1;
		 end
		 
		 else if(Y[7:4] == 4'b1001)begin
			Y[7:4] = 0;
			Y[11:8] = Y[11:8] + 1'b1;
		 end
		 
		 else if(Y[11:8] == 4'b1001)begin
			Y[11:8] = 0;
			Y[15:12] = Y[11:8] + 1'b1;
		 end
		 
		 else begin
			Y= Y + 1'b1;
		 end
		 
		 
	 


endmodule
