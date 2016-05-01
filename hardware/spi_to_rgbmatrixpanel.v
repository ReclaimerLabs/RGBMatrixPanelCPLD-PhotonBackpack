module SPI_to_RGBMatrixPanel( si, clk, reset, rgbs, row, clk_out, latch_out );

	input si;
    input clk;
    input reset;
    output [7:0] rgbs;
    output [3:0] row;
    output clk_out;
    output latch_out;
	
	wire si;
	wire clk;
    wire reset;
	
	reg   [2:0]  counter;
    reg   [7:0]  rgbs;
    reg   [3:0]  row;
    reg          clk_out;
    reg          latch_out;
    reg          latch_needed;
    reg          row_inc_needed;

    always @ (negedge clk or negedge reset) begin
        if (reset == 1'b0) begin
            clk_out <= 1'b0;
            latch_out <= 1'b0;
            latch_needed <= 1'b0;
        end else begin
	        if (counter[2:0] == 3'd0) begin
		        clk_out <= 1'b1;
                if (rgbs[6] == 1'b1) begin
                    latch_needed <= 1'b1;
                end
			end else begin
			    clk_out <= 1'b0;
                latch_needed <= 1'b0;
			end
            if (latch_needed == 1'b1) begin
                latch_out <= 1'b1;
            end else begin
                latch_out <= 1'b0;
            end
        end
    end

    always @ (posedge clk or negedge reset) begin
	    if (reset == 1'b0) begin
            rgbs[7:0] <= 8'b00000000;
            counter <= 3'b000;
            row <= 4'b1111;
        end else begin
            counter <= counter + 1;
	        rgbs[7:0] <= {rgbs[6:0], si};
            if (counter[2:0] == 3'b000) begin
                if (rgbs[7] == 1'b1) begin
                    row_inc_needed <= 1'b1;
                end
            end else begin
                row_inc_needed <= 1'b0;
            end            
            if (row_inc_needed == 1'b1) begin
                row <= row + 1;
            end
        end 
    end

endmodule

