module ripple_adder_4bit (
    input wire [3:0] A,
    input wire [3:0] B,
    input wire       CIN,
    output wire [3:0] SUM,
    output wire       COUT
);
    wire C1;
    wire C2;
    wire C3;

    full_adder FA0 (
        .A(A[0]),
        .B(B[0]),
        .CIN(CIN),
        .SUM(SUM[0]),
        .COUT(C1)
    );

    full_adder FA1 (
        .A(A[1]),
        .B(B[1]),
        .CIN(C1),
        .SUM(SUM[1]),
        .COUT(C2)
    );

    full_adder FA2 (
        .A(A[2]),
        .B(B[2]),
        .CIN(C2),
        .SUM(SUM[2]),
        .COUT(C3)
    );

    full_adder FA3 (
        .A(A[3]),
        .B(B[3]),
        .CIN(C3),
        .SUM(SUM[3]),
        .COUT(COUT)
    );
endmodule
