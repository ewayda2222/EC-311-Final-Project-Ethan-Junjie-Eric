
/* Basic clock divider
 *
 * To change the division factor, change the COUNTER_DIV
 * @param COUNTER_DIV The division factor (number of bits in the counter)
 * @param clk_in Input clock
 * @param clk_out Output clock
 */
module clock_divider_4 (clk_out, clk_in);
   parameter COUNTER_DIV = 100000;
   
   input clk_in;
   output reg clk_out;

   reg [16:0] counter;

   initial begin
      counter = 0;
      // clk_out = 0;
   end

   always @ (posedge clk_in) 
	begin
      if (counter == COUNTER_DIV -1)begin
			clk_out = ~clk_out;
			counter = 0;
			end
		else
			counter = counter + 1'b1;
   end

 //  assign clk_out = (counter == 0) ? ~clk_out : clk_out;

endmodule // clock_divider_4
