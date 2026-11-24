module stopwatch_top (
    input wire clk,
    input wire rst,
    input wire start_stop,
    output wire [6:0] seg,
    output wire dp,
    output wire [7:0] an
);
    wire tick_100hz;
    wire start_pressed;
    reg running;
    wire [3:0] cs_units;
    wire [3:0] cs_tens;
    wire [3:0] sec_units;
    wire [3:0] sec_tens;
    wire [3:0] min_units;
    wire [3:0] min_tens;

    clock_enable_100hz clock_enable (
        .clk(clk),
        .rst(rst),
        .tick(tick_100hz)
    );

    button_interface button (
        .clk(clk),
        .rst(rst),
        .button(start_stop),
        .pressed(start_pressed)
    );

    always @(posedge clk) begin
        if (rst)
            running <= 1'b0;
        else if (start_pressed)
            running <= ~running;
    end

    stopwatch_counter counter (
        .clk(clk),
        .rst(rst),
        .tick_100hz(tick_100hz),
        .running(running),
        .cs_units(cs_units),
        .cs_tens(cs_tens),
        .sec_units(sec_units),
        .sec_tens(sec_tens),
        .min_units(min_units),
        .min_tens(min_tens)
    );

    seven_seg_mux display (
        .clk(clk),
        .rst(rst),
        .digit0(cs_units),
        .digit1(cs_tens),
        .digit2(sec_units),
        .digit3(sec_tens),
        .digit4(min_units),
        .digit5(min_tens),
        .digit6(4'd0),
        .digit7(4'd0),
        .seg(seg),
        .dp(dp),
        .an(an)
    );
endmodule
