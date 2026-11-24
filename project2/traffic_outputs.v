module traffic_outputs (
    input wire [3:0] state,
    output reg ew_red,
    output reg ew_yellow,
    output reg ew_green,
    output reg ns_red,
    output reg ns_yellow,
    output reg ns_green,
    output reg ped_walk,
    output reg ped_stop
);
    localparam [3:0]
        S_RESET = 4'd0,
        S_EW_GREEN = 4'd1,
        S_EW_YELLOW = 4'd2,
        S_ALL_RED_EW_NS = 4'd3,
        S_NS_GREEN = 4'd4,
        S_NS_YELLOW = 4'd5,
        S_ALL_RED_NS_EW = 4'd6,
        S_PED_WALK = 4'd7,
        S_PED_CLEAR = 4'd8;

    always @(*) begin
        ew_red = 1'b1;
        ew_yellow = 1'b0;
        ew_green = 1'b0;
        ns_red = 1'b1;
        ns_yellow = 1'b0;
        ns_green = 1'b0;
        ped_walk = 1'b0;
        ped_stop = 1'b1;

        case (state)
            S_EW_GREEN: begin
                ew_red = 1'b0;
                ew_green = 1'b1;
            end
            S_EW_YELLOW: begin
                ew_red = 1'b0;
                ew_yellow = 1'b1;
            end
            S_NS_GREEN: begin
                ns_red = 1'b0;
                ns_green = 1'b1;
            end
            S_NS_YELLOW: begin
                ns_red = 1'b0;
                ns_yellow = 1'b1;
            end
            S_PED_WALK: begin
                ped_walk = 1'b1;
                ped_stop = 1'b0;
            end
            default: begin
            end
        endcase
    end
endmodule
