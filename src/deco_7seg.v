module deco_7seg (
input [7:0] entrada,
output reg [6:0] salida
);

always @(*) begin
    case (entrada)
	0: salida = 7'b0111111;
	1: salida = 7'b0000110;
	2: salida = 7'b1011011;
	3: salida = 7'b1001111;
	4: salida = 7'b1100110;
	5: salida = 7'b1101101;
	6: salida = 7'b1111000;
	7: salida = 7'b0000111;
	8: salida = 7'b1111111;
	9: salida = 7'b1100111;
	10: salida =7'b1110111;
	11: salida =7'b1111100;
	12: salida =7'b1011000;
	13: salida =7'b1011110;
	14: salida =7'b1111001;
	15: salida =7'b1110001;
	default: salida = 7'b1111111;
endcase
end
endmodule
