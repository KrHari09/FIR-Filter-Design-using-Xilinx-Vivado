module fir_filter(clk, reset, data_in, data_out);

parameter N = 16;

input clk, reset;
input signed [N-1:0] data_in;
output reg signed [N-1:0] data_out;

// coefficients definition
// 0.25 x 128 (scaling factor) = 32 = 6'b100000
wire [5:0] b0 =  6'b000000;
wire [5:0] b1 =  6'b000001;
wire [5:0] b2 =  6'b000111;
wire [5:0] b3 =  6'b001111;
wire [5:0] b4 =  6'b010011;
wire [5:0] b5 =  6'b001111;
wire [5:0] b6 =  6'b000111;
wire [5:0] b7 =  6'b000001;
wire [5:0] b8 =  6'b000000;
wire [N-1:0] x1, x2, x3, x4, x5, x6, x7, x8;

// Create delays i.e x[n-1], x[n-2], .. x[n-M]
// Instantiate D Flip Flops
DFF DFF0(clk, 0, data_in, x1); // x[n-1]
DFF DFF1(clk, 0, x1, x2);      // [x[n-2]]
DFF DFF2(clk, 0, x2, x3);
DFF DFF3(clk, 0, x3, x4); // x[n-1]
DFF DFF4(clk, 0, x4, x5);      // [x[n-2]]
DFF DFF5(clk, 0, x5, x6);
DFF DFF6(clk, 0, x6, x7); // x[n-1]
DFF DFF7(clk, 0, x7, x8);

  // Multiplication
wire [N-1:0] Mul0, Mul1, Mul2, Mul3, Mul4, Mul5, Mul6, Mul7, Mul8;
assign Mul0 = b0;
assign Mul1 = data_in * b1;
assign Mul2 = x1 * b2;
assign Mul3 = x2 * b3;
assign Mul4 = x3 * b4;
assign Mul5 = x4 * b5;
assign Mul6 = x5 * b6;
assign Mul7 = x6 * b7;
assign Mul8 = x7 * b8;

wire [N-1:0] Add_final; // Addition operation
assign Add_final = Mul0 + Mul1 + Mul2 + Mul3+Mul4+ Mul5+ Mul6+ Mul7+Mul8;
always @(posedge clk) data_out <= Add_final; // Final calculation to output

endmodule

module DFF(clk, reset, data_in, data_delayed);
parameter N = 16;
input clk, reset;   input [N-1:0] data_in;
output reg [N-1:0] data_delayed;

always @(posedge clk)
begin
    if (reset)
        data_delayed <= 0;
    else
        data_delayed <= data_in;
end
endmodule
