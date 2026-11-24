module stopwatch_counter (
    input wire clk,
    input wire rst,
    input wire tick_100hz,
    input wire running,
    output reg [3:0] cs_units,
    output reg [3:0] cs_tens,
    output reg [3:0] sec_units,
    output reg [3:0] sec_tens,
    output reg [3:0] min_units,
    output reg [3:0] min_tens
);
    always @(posedge clk) begin
        if (rst) begin
            cs_units <= 0;
            cs_tens <= 0;
            sec_units <= 0;
            sec_tens <= 0;
            min_units <= 0;
            min_tens <= 0;
        end else if (tick_100hz && running) begin
            if (cs_units == 9) begin
                cs_units <= 0;
                if (cs_tens == 9) begin
                    cs_tens <= 0;
                    if (sec_units == 9) begin
                        sec_units <= 0;
                        if (sec_tens == 5) begin
                            sec_tens <= 0;
                            if (min_units == 9) begin
                                min_units <= 0;
                                if (min_tens == 5)
                                    min_tens <= 0;
                                else
                                    min_tens <= min_tens + 1'b1;
                            end else begin
                                min_units <= min_units + 1'b1;
                            end
                        end else begin
                            sec_tens <= sec_tens + 1'b1;
                        end
                    end else begin
                        sec_units <= sec_units + 1'b1;
                    end
                end else begin
                    cs_tens <= cs_tens + 1'b1;
                end
            end else begin
                cs_units <= cs_units + 1'b1;
            end
        end
    end
endmodule
