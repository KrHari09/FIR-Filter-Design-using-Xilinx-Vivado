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
