`default_nettype none

module tt_um_fir_top #(parameter N = 8, parameter SIZE = 8, parameter NUM_COEFF = 4) (
    input  wire [7:0] ui_in,    // Dedicated inputs - connected to the input switches
    output wire [7:0] uo_out,   // Dedicated outputs - connected to the 7 segment display
    input  wire [7:0] uio_in,   // IOs: Bidirectional Input path
    output wire [7:0] uio_out,  // IOs: Bidirectional Output path
    output wire [7:0] uio_oe,   // IOs: Bidirectional Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

assign uio_out = 0
assign uio_oe = 0

wire [7:0] serial_in;
assign serial_in = ui_in;

wire [7:0] y_n;
assign uo_out = y_n;

wire [NUM_COEFF*SIZE-1:0] parallel_out;


wire [SIZE*NUM_COEFF-1:0] coeffs;

assign coeffs[SIZE-1:0] = 1;
assign coeffs[SIZE*2-1:SIZE] = 2;
assign coeffs[SIZE*3-1:SIZE*2] = 3;
assign coeffs[SIZE*4-1:SIZE*3] = 4;

shift_register #(.N(NUM_COEFF), .SIZE(SIZE)) sr (
.clk(clk),
.reset(rst_n),
.serial_in(serial_in),
.parallel_out(parallel_out),
.en(ena)
);

fir #(.NUM_COEFF(NUM_COEFF), .NUMBER_SIZE(SIZE)) f (
.x_ns(parallel_out),
.y_n(y_n),
.coeffs(coeffs)
);




endmodule
