`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Boston University
// Engineer: Zafar M. Takhirov
// 
// Create Date:    12:59:40 04/12/2011 
// Design Name: EC311 Support Files
// Module Name:    vga_display 
// Project Name: Lab5 / Lab6 / Project
// Target Devices: xc6slx16-3csg324
// Tool versions: XILINX ISE 13.3
// Description: 
//
// Dependencies: vga_controller_640_60
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module vga_display(rst, clk, R, G, B, HS, VS, R_control, G_control, B_control,trigger1,trigger2,trigger3,trigger4,AN,seven);
    input rst;  // global reset
    input clk;  // 100MHz clk
    
    // color inputs for a given pixel
    input [2:0] R_control, G_control;
    input [1:0] B_control; 
    
    // color outputs to show on display (current pixel)
    output reg [2:0] R, G;
    output reg [1:0] B;
    
    // Synchronization signals
    output HS;
    output VS;
    
    // controls:
    wire [10:0] hcount, vcount; // coordinates for the current pixel
    wire blank; // signal to indicate the current coordinate is blank
    wire moving_box1,moving_box2,moving_box3,moving_box4;
	 wire stable_box1,stable_box2,stable_box3,stable_box4;   // the moving_box1 you want to display
	 
	 parameter S_IDLE = 0;   // 0000 - no button pushed      // 0001 - the first button pushed
    parameter S_DOWN = 1;   // 0010 - the second button pushed
    // 1000 - and so on

    reg [3:0] state1, state2,state3,state4, next_state1,next_state2,next_state3,next_state4;
    ////////////////////////////////////////

    //input up, down, left, right;    // 1 bit inputs
    reg [10:0] y1,y2,y3,y4;                //currentposition variables
    reg slow_clk1,slow_clk2,slow_clk3,slow_clk4;
  
	 
	 input trigger1,trigger2,trigger3,trigger4;
	 output [3:0] AN;
	 output [6:0] seven;
	 
    
    /////////////////////////////////////////////////////
    // Begin clock division
    parameter N = 2;    // parameter for clock division
    reg clk_25Mhz;
    reg [N-1:0] count;
    always @ (posedge clk) begin
        count <= count + 1'b1;
        clk_25Mhz <= count[N-1];
    end
    // End clock division
    /////////////////////////////////////////////////////
	 
	 
	 //timer for moving box
 reg [10:0] x;
 
 initial begin
	x=21;
	end

	reg [50:0] slow_count1, slow_count2;  
    always @ (posedge clk)begin
        slow_count1 = slow_count1 + 1'b1;
		  slow_count2 = slow_count2 + 1'b1;
        slow_clk1 = slow_count1[x] ; // + 4'b1111
		  
        slow_clk2 = slow_count1[x] ;
		  
        slow_clk3 = slow_count1[x];
		  
        slow_clk4 = slow_count1[x];
		  
		  if (slow_count2[31] == 1 && x >19) begin
				x = x-1;
				slow_count2 = 0;
		  
		  end
    end

	 always @ (posedge slow_clk1)begin
        state1 = next_state1; 
    end

    always @ (posedge slow_clk1) begin   
        case (state1)
            S_IDLE: next_state1 = {slow_clk1}; // if input is 0000
            S_DOWN: begin 
					if (y1 != 530) begin
						 y1 = y1 + 5;
						 next_state1 = {slow_clk1};
					end
					else begin
						 y1 = 0;
						 next_state1 = {slow_clk1};
					end
				end
              
        endcase
    end
    
	 
	 
	 always @ (posedge slow_clk1)begin
        state2 = next_state2; 
    end

    always @ (posedge slow_clk1) begin   
        case (state2)
            S_IDLE: next_state2 = {slow_clk1}; // if input is 0000
            S_DOWN: begin 
					if (y2 != 510) begin
						 y2 = y2 + 5;
						 next_state2 = {slow_clk1};
					end
					else begin
						 y2 = 0;
						 next_state2 = {slow_clk1};
					end
				end
              
        endcase
    end
    
	 
	 always @ (posedge slow_clk1)begin
        state3 = next_state3; 
    end

    always @ (posedge slow_clk1) begin   
        case (state3)
            S_IDLE: next_state3 = {slow_clk1}; // if input is 0000
            S_DOWN: begin 
					if (y3 != 570) begin
						 y3 = y3 + 5;
						 next_state3 = {slow_clk1};
					end
					else begin
						 y3 = 0;
						 next_state3 = {slow_clk1};
					end
				end
              
        endcase
    end
    
	 
	 always @ (posedge slow_clk1)begin
        state4 = next_state4; 
    end

    always @ (posedge slow_clk1) begin   
        case (state4)
            S_IDLE: next_state4 = {slow_clk1}; // if input is 0000
            S_DOWN: begin 
					if (y4 != 520) begin
						 y4 = y4 + 5;
						 next_state4 = {slow_clk1};
					end
					else begin
						 y4 = 0;
						 next_state4 = {slow_clk1};
					end
				end
              
        endcase
    end
    
	 
	 
	 
    // Call driver
    vga_controller_640_60 vc(
        .rst(rst), 
        .pixel_clk(clk_25Mhz), 
        .HS(HS), 
        .VS(VS), 
        .hcounter(hcount), 
        .vcounter(vcount), 
        .blank(blank));
    
    // create a box:
    assign moving_box1 = ~blank & (hcount >= 60 & hcount <= 140 & vcount >= y1 & vcount <= y1+50);
	 assign stable_box1 = ~blank & (hcount >= 60 & hcount <= 140 & vcount >= 350 & vcount <= 400);
	 
	 assign moving_box2 = ~blank & (hcount >= 220 & hcount <= 300 & vcount >= y2 & vcount <= y2+50);
	 assign stable_box2 = ~blank & (hcount >= 220 & hcount <= 300 & vcount >= 350 & vcount <= 400);
	 
	 assign moving_box3 = ~blank & (hcount >= 380 & hcount <= 460 & vcount >= y3& vcount <= y3+50);
	 assign stable_box3 = ~blank & (hcount >= 380 & hcount <= 460 & vcount >= 350 & vcount <= 400);
	 
	 assign moving_box4 = ~blank & (hcount >= 540 & hcount <= 620 & vcount >= y4 & vcount <= y4+50);
	 assign stable_box4 = ~blank & (hcount >= 540 & hcount <= 620 & vcount >= 350 & vcount <= 400);
	 
	 
    // send colors:
    always @ (posedge clk) begin
        if (moving_box1) begin   // if you are within the valid region
            R = 0;
            G = 0;
            B = 255;
        end
		  else if (hcount >= 60 & hcount <= 140 & vcount >= 350 & vcount <= 400)begin
				R = 255;
            G = 255;
            B = 255;
		  end
		  
		  else if (moving_box2) begin   // if you are within the valid region
            R = 0;
            G = 255;
            B = 0;
        end
		  else if (hcount >= 220 & hcount <= 300 & vcount >= 350 & vcount <= 400)begin
				R = 255;
            G = 255;
            B = 255;
		  end
		  
		  else if (moving_box3) begin   // if you are within the valid region
            R = 255;
            G = 0;
            B = 0;
        end
		  else if (hcount >= 380 & hcount <= 460 & vcount >= 350 & vcount <= 400)begin
				R = 255;
            G = 255;
            B = 255;
		  end
		  
		  else if (moving_box4) begin   // if you are within the valid region
            R = 255;
            G = 255;
            B = 0;
        end
		  else if (hcount >= 540 & hcount <= 620 & vcount >= 350 & vcount <= 400)begin
				R = 255;
            G = 255;
            B = 255;
		  end
		  
		  
		  
		  
		  
		  
        else begin  // if you are outside the valid region
            R = 0;
            G = 0;
            B = 0;
        end
    end
	 
	 //Buttons
	 wire debounced_click1,debounced_click2,debounced_click3,debounced_click4;
	 wire f2,f1,f3,f4,f5,f6,f7,f8;
	 
	 Debouncer df1(clk, trigger1, debounced_click1, f1,  f2);
	 Debouncer df2(clk, trigger2, debounced_click2, f3, f4);
	 Debouncer df3(clk, trigger3, debounced_click3, f5, f6);
	 Debouncer df4(clk, trigger4, debounced_click4, f7, f8);
	 
	 
	 reg if_overlap,if_overlap1,if_overlap2,if_overlap3,if_overlap4;

	 reg [15:0] true_count1, true_count2,true_count3,true_count4;
	 always @(clk)begin
		if (~debounced_click1)begin
			if(moving_box1 & stable_box1)begin
				true_count1 = true_count1 + 1'b1; 
				if (true_count1 > 1'b0)
					if_overlap1= 1;
			end
		end
		else begin
			if_overlap1=0;
			true_count1 = 1'b0;
		end
	 end
	 
	 always @(clk)begin
		if (~debounced_click2)begin
			if(moving_box2 & stable_box2)begin
				true_count2 = true_count2 + 1'b1; 
				if (true_count2 > 1'b0)
					if_overlap2= 1;
			end
		end
		else begin
			if_overlap2=0;
			true_count2 = 1'b0;
		end
	 end
	 
	  always @(clk)begin
		if (~debounced_click3)begin
			if(moving_box3 & stable_box3)begin
				true_count3 = true_count3 + 1'b1; 
				if (true_count3 > 1'b0)
					if_overlap3= 1;
			end
		end
		else begin
			if_overlap3=0;
			true_count3 = 1'b0;
		end
	 end
	 
	 
	  always @(clk)begin
		if (~debounced_click4)begin
			if(moving_box4 & stable_box4)begin
				true_count4 = true_count4 + 1'b1; 
				if (true_count4 > 1'b0)
					if_overlap4= 1;
			end
		end
		else begin
			if_overlap4=0;
			true_count4 = 1'b0;
		end
	 end
	 

		together TF(seven, AN, clk, (if_overlap1 || if_overlap2|| if_overlap3|| if_overlap4));

	 
	 
	 
	 
	 


endmodule
