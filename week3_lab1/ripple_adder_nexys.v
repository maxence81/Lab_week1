module ripple_adder_nexys (
    input wire [8:0] sw,
    output wire [4:0] led
);
    ripple_adder_4bit adder (
        .A(sw[3:0]),
        .B(sw[7:4]),
        .CIN(sw[8]),
        .SUM(led[3:0]),
        .COUT(led[4])
    );
endmodule
