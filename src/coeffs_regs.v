module coeffs_regs (
    input [7:0] coeff,
    input [1:0] sel,
    input en, rst, clk,
    output reg [32-1:0] out
);

always @(posedge clk) begin
    if (!rst) begin
        out <= 32'b00000001000000010000000100000001;
    end
    else if (en) begin
	out[sel*8 +: 8] <= coeff;
    end
end

endmodule

