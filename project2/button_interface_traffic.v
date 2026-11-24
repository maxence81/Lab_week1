module button_interface_traffic #(
    parameter integer DEBOUNCE_CYCLES = 2_000_000
) (
    input wire clk,
    input wire rst,
    input wire button_in,
    output reg button_pulse
);
    reg sync_1;
    reg sync_2;
    reg stable_button;
    reg [31:0] debounce_count;

    always @(posedge clk) begin
        if (rst) begin
            sync_1 <= 1'b0;
            sync_2 <= 1'b0;
            stable_button <= 1'b0;
            debounce_count <= 32'd0;
            button_pulse <= 1'b0;
        end else begin
            sync_1 <= button_in;
            sync_2 <= sync_1;
            button_pulse <= 1'b0;

            if (sync_2 == stable_button) begin
                debounce_count <= 32'd0;
            end else if (debounce_count == DEBOUNCE_CYCLES - 1) begin
                stable_button <= sync_2;
                debounce_count <= 32'd0;
                if (sync_2)
                    button_pulse <= 1'b1;
            end else begin
                debounce_count <= debounce_count + 1'b1;
            end
        end
    end
endmodule
