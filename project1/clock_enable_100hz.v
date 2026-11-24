module clock_enable_100hz #(
    parameter integer CLK_FREQ_HZ = 100_000_000,
    parameter integer TICK_HZ = 100
) (
    input wire clk,
    input wire rst,
    output reg tick
);
    localparam integer DIVISOR = CLK_FREQ_HZ / TICK_HZ;
    localparam integer COUNT_WIDTH = (DIVISOR <= 2) ? 1 : $clog2(DIVISOR);
    reg [COUNT_WIDTH-1:0] count;

    always @(posedge clk) begin
        if (rst) begin
            count <= 0;
            tick <= 1'b0;
        end else if (count == DIVISOR - 1) begin
            count <= 0;
            tick <= 1'b1;
        end else begin
            count <= count + 1'b1;
            tick <= 1'b0;
        end
    end
endmodule
