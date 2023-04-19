module HA (
    input  wire a,
    input  wire b,
    output wire sum,
    output wire cout
);
    assign sum = a ^ b;
    assign cout = a & b;

endmodule //HA