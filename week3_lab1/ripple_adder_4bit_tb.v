`timescale 1ns/1ps

module ripple_adder_4bit_tb;
    reg [3:0] A;
    reg [3:0] B;
    reg CIN;
    wire [3:0] SUM;
    wire COUT;

    integer passed;
    integer failed;

    ripple_adder_4bit dut (
        .A(A),
        .B(B),
        .CIN(CIN),
        .SUM(SUM),
        .COUT(COUT)
    );

    task check_case;
        input [3:0] test_a;
        input [3:0] test_b;
        input test_cin;
        input [4:0] expected;
        begin
            A = test_a;
            B = test_b;
            CIN = test_cin;
            #1;

            if ({COUT, SUM} === expected) begin
                passed = passed + 1;
                $display("PASS: A=%0d B=%0d CIN=%b result=%b",
                         A, B, CIN, {COUT, SUM});
            end
            else begin
                failed = failed + 1;
                $display("FAIL: A=%0d B=%0d CIN=%b expected=%b actual=%b",
                         A, B, CIN, expected, {COUT, SUM});
            end
        end
    endtask

    initial begin
        $dumpfile("ripple_adder_4bit.vcd");
        $dumpvars(0, ripple_adder_4bit_tb);

        passed = 0;
        failed = 0;

        check_case(4'd0,  4'd0,  1'b0, 5'b00000);
        check_case(4'd3,  4'd2,  1'b0, 5'b00101);
        check_case(4'd7,  4'd5,  1'b0, 5'b01100);
        check_case(4'd9,  4'd6,  1'b1, 5'b10000);
        check_case(4'd15, 4'd15, 1'b0, 5'b11110);
        check_case(4'd15, 4'd15, 1'b1, 5'b11111);

        $display("Ripple-adder results: %0d passed, %0d failed",
                 passed, failed);
        $finish;
    end
endmodule
