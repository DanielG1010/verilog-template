`default_nettype none
`timescale 1ns/1ps

/*
this testbench just instantiates the module and makes some convenient wires
that can be driven / tested by the cocotb test.py
*/

// testbench is controlled by test.py
module fir_tb ();

    // this part dumps the trace to a vcd file that can be viewed with GTKWave
    initial begin
        $dumpfile ("fir_tb.vcd");
        $dumpvars (0, fir_tb);
        #1;
    end
    
    // parametros
    parameter NUMBER_SIZE = 16;
    parameter NUM_COEFF = 4;
    
    // wire up the inputs and outputs
    reg  clk;
    reg  rst_n;
    reg  ena;

    reg [NUM_COEFF*NUMBER_SIZE-1:0] x_ns;
    wire [NUMBER_SIZE-1:0] y_n;
    reg [NUM_COEFF*NUMBER_SIZE-1:0] coeffs;
	
    fir f1(.x_ns(x_ns), .y_n(y_n),.coeffs(coeffs));
    
    
    initial begin
	x_ns = 0;
	coeffs = 0;
	coeffs[NUMBER_SIZE-1:0] = 1;
	coeffs[NUMBER_SIZE*2-1:NUMBER_SIZE] = 2;
	#10
	#10
	x_ns = 1;
	#20
	x_ns = 2;
	#20
	$finish;
     end
    
endmodule
