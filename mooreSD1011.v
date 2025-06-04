module Sequence_Detector_MOORE_Verilog(
    
    input clock,          // clock signal
    input reset,          // reset input
    input sequence_in,    // binary input
    output reg detector_out  // output of the sequence detector
    
    );

    parameter Zero = 3'b000,       // "Zero" State
              One = 3'b001,        // "One" State
              OneZero = 3'b011,    // "OneZero" State
              OneZeroOne = 3'b010,// "OneZeroOne" State
              OneZeroOneOne = 3'b110; // "OneZeroOneOne" State

    reg [2:0] current_state, next_state; // current and next state

    // sequential memory of the Moore FSM
    always @(posedge clock, posedge reset) begin
        if (reset == 1)
            current_state <= Zero;      // reset state
        else
            current_state <= next_state;
    end 

    // combinational logic to determine next state
    always @(current_state, sequence_in) begin
        case(current_state)
            Zero: begin
                if(sequence_in == 1)
                    next_state = One;
                else
                    next_state = Zero;
            end
            One: begin
                if(sequence_in == 0)
                    next_state = OneZero;
                else
                    next_state = One;
            end
            OneZero: begin
                if(sequence_in == 0)
                    next_state = Zero;
                else
                    next_state = OneZeroOne;
            end
            OneZeroOne: begin
                if(sequence_in == 0)
                    next_state = OneZero;
                else
                    next_state = OneZeroOneOne;
            end
            OneZeroOneOne: begin
                if(sequence_in == 0)
                    next_state = OneZero;
                else
                    next_state = One;
            end
            default: next_state = Zero;
        endcase
    end

    // output logic depends only on current state (Moore)
    always @(current_state) begin
        case(current_state)
            Zero: detector_out = 0;
            One: detector_out = 0;
            OneZero: detector_out = 0;
            OneZeroOne: detector_out = 0;
            OneZeroOneOne: detector_out = 1;
            default: detector_out = 0;
        endcase
    end 

endmodule
