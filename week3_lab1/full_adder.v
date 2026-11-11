module full_adder (
    input wire A,
    input wire B,
    input wire CIN,
    output wire SUM,
    output wire COUT
);
    wire sum1;
    wire carry1;
    wire carry2;

    half_adder HA1 (
        .A(A),
        .B(B),
        .SUM(sum1),
        .CARRY(carry1)
    );

    half_adder HA2 (
        .A(sum1),
        .B(CIN),
        .SUM(SUM),
        .CARRY(carry2)
    );

    assign COUT = carry1 | carry2;
endmodule
