module button_interface #(
    parameter integer DEBOUNCE_CYCLES = 1_000_000
) (
    input wire clk,
    input wire rst,
    input wire button,
    output reg pressed
);
    localparam integer COUNT_WIDTH =
        (DEBOUNCE_CYCLES <= 2) ? 1 : $clog2(DEBOUNCE_CYCLES);
    reg sync_1;
    reg sync_2;
    reg stable_state;
    reg [COUNT_WIDTH-1:0] count;

    always @(posedge clk) begin
        if (rst) begin
            sync_1 <= 1'b0;
            sync_2 <= 1'b0;
            stable_state <= 1'b0;
            count <= 0;
            pressed <= 1'b0;
        end else begin
            sync_1 <= button;
            sync_2 <= sync_1;
            pressed <= 1'b0;

            if (sync_2 == stable_state) begin
                count <= 0;
            end else if (count == DEBOUNCE_CYCLES - 1) begin
                stable_state <= sync_2;
                count <= 0;
                if (sync_2)
                    pressed <= 1'b1;
            end else begin
                count <= count + 1'b1;
            end
        end
    end
endmodule
