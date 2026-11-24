module traffic_fsm #(
    parameter integer EW_GREEN_S = 4,
    parameter integer EW_YELLOW_S = 2,
    parameter integer NS_GREEN_S = 4,
    parameter integer NS_YELLOW_S = 2,
    parameter integer ALL_RED_S = 1,
    parameter integer WALK_S = 3,
    parameter integer CLEAR_S = 1
) (
    input wire clk,
    input wire rst,
    input wire tick_1hz,
    input wire button_pulse,
    output reg [3:0] state
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

    reg [31:0] elapsed_s;
    reg request_pending;

    always @(posedge clk) begin
        if (rst) begin
            state <= S_RESET;
            elapsed_s <= 32'd0;
            request_pending <= 1'b0;
        end else if (state == S_RESET) begin
            state <= S_EW_GREEN;
            elapsed_s <= 32'd0;
            request_pending <= 1'b0;
        end else begin
            if (button_pulse)
                request_pending <= 1'b1;

            if (tick_1hz) begin
                case (state)
                    S_EW_GREEN: begin
                        if (elapsed_s >= EW_GREEN_S - 1) begin
                            state <= S_EW_YELLOW;
                            elapsed_s <= 0;
                        end else begin
                            elapsed_s <= elapsed_s + 1'b1;
                        end
                    end
                    S_EW_YELLOW: begin
                        if (elapsed_s >= EW_YELLOW_S - 1) begin
                            state <= S_ALL_RED_EW_NS;
                            elapsed_s <= 0;
                        end else begin
                            elapsed_s <= elapsed_s + 1'b1;
                        end
                    end
                    S_ALL_RED_EW_NS: begin
                        if (elapsed_s >= ALL_RED_S - 1) begin
                            elapsed_s <= 0;
                            if (request_pending || button_pulse) begin
                                state <= S_PED_WALK;
                                request_pending <= 1'b0;
                            end else begin
                                state <= S_NS_GREEN;
                            end
                        end else begin
                            elapsed_s <= elapsed_s + 1'b1;
                        end
                    end
                    S_NS_GREEN: begin
                        if (elapsed_s >= NS_GREEN_S - 1) begin
                            state <= S_NS_YELLOW;
                            elapsed_s <= 0;
                        end else begin
                            elapsed_s <= elapsed_s + 1'b1;
                        end
                    end
                    S_NS_YELLOW: begin
                        if (elapsed_s >= NS_YELLOW_S - 1) begin
                            state <= S_ALL_RED_NS_EW;
                            elapsed_s <= 0;
                        end else begin
                            elapsed_s <= elapsed_s + 1'b1;
                        end
                    end
                    S_ALL_RED_NS_EW: begin
                        if (elapsed_s >= ALL_RED_S - 1) begin
                            elapsed_s <= 0;
                            if (request_pending || button_pulse) begin
                                state <= S_PED_WALK;
                                request_pending <= 1'b0;
                            end else begin
                                state <= S_EW_GREEN;
                            end
                        end else begin
                            elapsed_s <= elapsed_s + 1'b1;
                        end
                    end
                    S_PED_WALK: begin
                        if (elapsed_s >= WALK_S - 1) begin
                            state <= S_PED_CLEAR;
                            elapsed_s <= 0;
                        end else begin
                            elapsed_s <= elapsed_s + 1'b1;
                        end
                    end
                    S_PED_CLEAR: begin
                        if (elapsed_s >= CLEAR_S - 1) begin
                            state <= S_EW_GREEN;
                            elapsed_s <= 0;
                        end else begin
                            elapsed_s <= elapsed_s + 1'b1;
                        end
                    end
                    default: begin
                        state <= S_RESET;
                        elapsed_s <= 0;
                        request_pending <= 1'b0;
                    end
                endcase
            end
        end
    end
endmodule
