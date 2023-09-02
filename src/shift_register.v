module shift_register #(parameter N = 8, parameter SIZE = 8) (
    input clk,
    input reset,
    input en,
    input [SIZE-1:0] serial_in,
    output reg [N*SIZE-1:0] parallel_out
);
    always @(posedge clk) begin
        if (~reset) begin
            parallel_out <= 0;
        end else if (en) begin
            parallel_out <= {parallel_out[N*SIZE-SIZE-1:0], serial_in};
        end
	else begin
	    parallel_out <= parallel_out;
	end
    end
endmodule

