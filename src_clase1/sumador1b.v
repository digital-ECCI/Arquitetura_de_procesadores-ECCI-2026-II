module sumador1b(
    input A,
    input B,
    input Ci,
    output S,
    output Co
);

assign S = A ^ (B^Ci);
assign Co = B&(A|Ci)|(A&Ci);


endmodule