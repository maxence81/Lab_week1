module traffic_top (
    input wire clk,
    input wire rst,
    input wire ped_button,
    output wire ew_red,
    output wire ew_yellow,
    output wire ew_green,
    output wire ns_red,
    output wire ns_yellow,
    output wire ns_green,
    output wire ped_walk,
    output wire ped_stop
);
    wire tick_1hz;
    wire button_pulse;
    wire [3:0] state;

    clock_enable_1hz clock_enable (
        .clk(clk),
        .rst(rst),
        .tick_1hz(tick_1hz)
    );

    button_interface_traffic button (
        .clk(clk),
        .rst(rst),
        .button_in(ped_button),
        .button_pulse(button_pulse)
    );

    traffic_fsm fsm (
        .clk(clk),
        .rst(rst),
        .tick_1hz(tick_1hz),
        .button_pulse(button_pulse),
        .state(state)
    );

    traffic_outputs outputs (
        .state(state),
        .ew_red(ew_red),
        .ew_yellow(ew_yellow),
        .ew_green(ew_green),
        .ns_red(ns_red),
        .ns_yellow(ns_yellow),
        .ns_green(ns_green),
        .ped_walk(ped_walk),
        .ped_stop(ped_stop)
    );
endmodule
