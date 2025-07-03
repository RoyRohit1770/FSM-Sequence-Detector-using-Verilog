module Sequence_Detector_MOORE_Verilog (
    input sequence_in,
    input clock,
    input reset,
    output reg detector_out
);

    parameter S0 = 3'b000;
    parameter S1 = 3'b001;
    parameter S2 = 3'b010;
    parameter S3 = 3'b011;
    parameter S4 = 3'b100;

    reg [2:0] state, next_state;

    // State register
    always @(posedge clock or posedge reset) begin
        if (reset)
            state <= S0;
        else
            state <= next_state;
    end

    // Next-state logic
    always @(*) begin
        case (state)
            S0: next_state = (sequence_in == 1) ? S1 : S0;
            S1: next_state = (sequence_in == 0) ? S2 : S1;
            S2: next_state = (sequence_in == 1) ? S3 : S0;
            S3: next_state = (sequence_in == 1) ? S4 : S2;
            S4: next_state = (sequence_in == 1) ? S1 : S2;
            default: next_state = S0;
        endcase
    end

    // Output logic (Moore)
    always @(*) begin
        if (state == S4)
            detector_out = 1;
        else
            detector_out = 0;
    end

endmodule
