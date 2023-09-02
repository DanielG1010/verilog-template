`default_nettype none

module fir #(parameter NUM_COEFF = 4, NUMBER_SIZE=16) (
    input  wire [NUM_COEFF*NUMBER_SIZE-1:0] x_ns,    // Values x[n] input for several ns
    output wire [NUMBER_SIZE-1:0] y_n,   // Value y[n] output
    input  wire [NUMBER_SIZE*NUM_COEFF-1:0] coeffs // Coeficientes del filtro
    //input  wire       ena,       // will go high when the design is enabled
    //input  wire       clk,       // clock
    //input  wire       rst_n      // reset_n - low to reset
);

wire [NUMBER_SIZE-1:0] sum1;
wire [NUMBER_SIZE-1:0] sum2;
wire [NUMBER_SIZE-1:0] sum3;
wire [NUMBER_SIZE-1:0] sum4;

assign sum1 = x_ns[NUMBER_SIZE-1:0]*coeffs[NUMBER_SIZE-1:0]; 
assign sum2 = x_ns[NUMBER_SIZE*2-1:NUMBER_SIZE]*coeffs[NUMBER_SIZE*2-1:NUMBER_SIZE];
assign sum3 = x_ns[NUMBER_SIZE*3-1:NUMBER_SIZE*2]*coeffs[NUMBER_SIZE*3-1:NUMBER_SIZE*2];
assign sum4 = x_ns[NUMBER_SIZE*4-1:NUMBER_SIZE*3]*coeffs[NUMBER_SIZE*4-1:NUMBER_SIZE*3];

assign y_n = sum1 + sum2 + sum3 + sum4;

endmodule
