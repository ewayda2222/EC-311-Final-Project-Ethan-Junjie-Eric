`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:34:02 11/11/2015 
// Design Name: 
// Module Name:    Lab3Final 
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
module Lab3Final(Y, trigger, clk);
	input trigger;
	input clk;
	output  [15:0] Y;
	wire [15:0] w1, f1 ,f2;
	

	
	Debouncer d1(clk, trigger, w1, f1, f2);
	basic_counter b1 (Y, w1);
	


endmodule
