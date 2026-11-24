`timescale 1ms / 1us

module tb_stopwatch_counter;
    reg clk;
    reg rst;
    reg tick_100hz;
    reg running;
    wire [3:0] cs_units, cs_tens, sec_units, sec_tens, min_units, min_tens;
    integer ticks;

    stopwatch_counter dut (
        .clk(clk), .rst(rst), .tick_100hz(tick_100hz),
        .running(running),
        .cs_units(cs_units), .cs_tens(cs_tens),
        .sec_units(sec_units), .sec_tens(sec_tens),
        .min_units(min_units), .min_tens(min_tens)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        tick_100hz = 0;
        running = 0;
        ticks = 0;
        #20;
        rst = 0;
        running = 1;

        repeat (100) begin
            @(negedge clk);
            tick_100hz = 1;
            @(negedge clk);
            tick_100hz = 0;
            ticks = ticks + 1;
        end

        #1;
        $display("After %0d ticks: %0d%0d:%0d%0d:%0d%0d",
                 ticks, min_tens, min_units, sec_tens,
                 sec_units, cs_tens, cs_units);
        if ({min_tens, min_units, sec_tens, sec_units, cs_tens, cs_units}
            !== 24'h000100)
            $fatal(1, "Counter rollover test failed");
        $display("PASS: stopwatch counter reached 00:01:00");
        $finish;
    end
endmodule
