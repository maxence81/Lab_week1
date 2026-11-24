module seven_seg_mux #(
    parameter integer REFRESH_DIVISOR = 100_000
) (
    input wire clk,
    input wire rst,
    input wire [3:0] digit0,
    input wire [3:0] digit1,
    input wire [3:0] digit2,
    input wire [3:0] digit3,
    input wire [3:0] digit4,
    input wire [3:0] digit5,
    input wire [3:0] digit6,
    input wire [3:0] digit7,
    output wire [6:0] seg,
    output wire dp,
    output reg [7:0] an
);
    localparam integer COUNT_WIDTH =
        (REFRESH_DIVISOR <= 2) ? 1 : $clog2(REFRESH_DIVISOR);
    reg [COUNT_WIDTH-1:0] refresh_count;
    reg [2:0] digit_select;
    reg [3:0] selected_bcd;

    always @(posedge clk) begin
        if (rst) begin
            refresh_count <= 0;
            digit_select <= 0;
        end else if (refresh_count == REFRESH_DIVISOR - 1) begin
            refresh_count <= 0;
            digit_select <= digit_select + 1'b1;
        end else begin
            refresh_count <= refresh_count + 1'b1;
        end
    end

    always @(*) begin
        case (digit_select)
            3'd0: selected_bcd = digit0;
            3'd1: selected_bcd = digit1;
            3'd2: selected_bcd = digit2;
            3'd3: selected_bcd = digit3;
            3'd4: selected_bcd = digit4;
            3'd5: selected_bcd = digit5;
            3'd6: selected_bcd = digit6;
            default: selected_bcd = digit7;
        endcase
        an = ~(8'b00000001 << digit_select);
    end

    bcd_to_7seg decoder (.bcd(selected_bcd), .seg(seg));
    assign dp = 1'b1;
endmodule
