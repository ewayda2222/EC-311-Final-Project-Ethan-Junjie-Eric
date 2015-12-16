`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:08:11 11/18/2015 
// Design Name: 
// Module Name:    together 
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
module together(seven, AN, clk, trigger 
    );
	 input clk;
	 input trigger;
	 output [3:0] AN;
	 output [6:0] seven;
	 wire [15:0] Y;
	 wire [3:0] w1;
	 wire clk_o;
	 
	 
	 basic_counter T1(Y, trigger);
	 clock_divider_4 C1(clk_o, clk);
	 seven_alternate S1(Y, w1, AN, clk_o);
	 binary_to_segment B1(w1,seven);	 
	 
	 
	 

endmodule
