`timescale 1ns / 1ps
// Import the external package
import some_package::*;

module boilerplate #(
    // Parameter declarations
    parameter int PARAM1 = 10,  // Example parameter with a default value
    parameter int PARAM2 = 20
) (
    // Port declarations (modify as needed)
    input  logic              clk,    // Clock input
    input  logic              reset,  // Reset input
    input  logic [PARAM1-1:0] in,     // Input port with width determined by PARAM1
    output logic [PARAM2-1:0] out     // Output port with width determined by PARAM2
);

  // Register declarations
  reg [PARAM1-1:0] reg1;  // Example register with width determined by PARAM1
  reg [PARAM2-1:0] reg2;  // Example register with width determined by PARAM2

  // Main logic
  always_ff @(posedge clk or negedge reset) begin
    if (!reset) begin
      // Reset logic
      reg1 <= 0;
      reg2 <= 0;
    end else begin
      // Sequential logic
      // Example: simple register operations
      reg1 <= in;
      reg2 <= reg1 + PARAM1 + 100;
    end
  end 

  // Assign output
  assign out = reg2;

endmodule
