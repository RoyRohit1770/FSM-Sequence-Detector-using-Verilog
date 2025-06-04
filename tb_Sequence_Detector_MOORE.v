`timescale 1ns / 1ps

module tb_Sequence_Detector_MOORE;

    // Inputs
    reg sequence_in;
    reg clock;
    reg reset;

    // Outputs
    wire detector_out;

    // Instantiate the Sequence Detector module
    Sequence_Detector_MOORE_Verilog uut (
        .sequence_in(sequence_in), 
        .clock(clock), 
        .reset(reset), 
        .detector_out(detector_out)
    );

    // Clock generation: 10ns period
    initial begin
        clock = 0;
        forever #5 clock = ~clock;
    end 

    // Test sequence
    initial begin
        // Initialize inputs
        sequence_in = 0;
        reset = 1;

        // Hold reset for a short time
        #30;
        reset = 0;

        // Apply input sequence: 1 0 1 1 (detect 1011)
        #40; sequence_in = 1;
        #10; sequence_in = 0;
        #10; sequence_in = 1; 
        #20; sequence_in = 1; 

        // Continue simulation for some time
        #50;
        $finish;
    end
      
endmodule
