`timescale 1ps / 1ps

module derived_module (
    input logic rst_n_i,  // Active low reset
    input logic sclk_i    // SPI clock
);

  logic [2:0] r_cnt;  // Bit counter

  // Output and register update logic
  always_ff @(posedge sclk_i or negedge rst_n_i) begin
    if (!rst_n_i) begin
      r_cnt <= 7;
    end else begin
      if (r_cnt == 0) begin
        r_cnt <= 7;  // Reset bit counter
      end else begin
        r_cnt <= r_cnt - 1;
      end
    end
  end

endmodule

