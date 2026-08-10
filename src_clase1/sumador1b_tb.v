`include "sumador1b.v"
`timescale 1s/1s

module sumadorTB();

reg A_tb;
reg B_tb;
reg Ci_tb;
wire S_tb;
wire Co_tb;


sumador1b uut(
    .A(A_tb),
    .B(B_tb),
    .Ci(Ci_tb),
    .S(S_tb),
    .Co(Co_tb)
);

initial begin
    A_tb  = 1'b0;
    B_tb  = 1'b0;
    Ci_tb = 1'b0;
end

initial begin
    //Caso 1
    A_tb  = 1'b0;
    B_tb  = 1'b0;
    Ci_tb = 1'b0;
    #5;
    A_tb  = 1'b0;
    B_tb  = 1'b0;
    Ci_tb = 1'b1;
    #5;
    A_tb  = 1'b0;
    B_tb  = 1'b1;
    Ci_tb = 1'b0;
    #5;
    A_tb  = 1'b0;
    B_tb  = 1'b1;
    Ci_tb = 1'b1;
    #5;
    A_tb  = 1'b1;
    B_tb  = 1'b0;
    Ci_tb = 1'b0;
end


initial begin:TEST_CASE
    $dumpfile("simulacion_tb.vcd");
    $dumpvars(-1,uut);
    #40;
end


endmodule