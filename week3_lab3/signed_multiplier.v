module signed_multiplier (
    input wire signed [7:0] A,
    input wire signed [7:0] B,
    output wire signed [15:0] PRODUCT
);
    assign PRODUCT = A * B;
endmodule
