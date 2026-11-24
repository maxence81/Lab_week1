module clock_enable_1hz #(
    parameter integer CLK_HZ = 100_000_000
) (
    input wire clk,
    input wire rst,
    output reg tick_1hz
);
    reg [31:0] count;

    always @(posedge clk) begin
        if (rst) begin
            count <= 32'd0;
            tick_1hz <= 1'b0;
        end else if (count == CLK_HZ - 1) begin
            count <= 32'd0;
            tick_1hz <= 1'b1;
        end else begin
            count <= count + 1'b1;
            tick_1hz <= 1'b0;
        end
    end
endmodule
