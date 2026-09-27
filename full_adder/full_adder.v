module full_adder (

    input  logic a,
    input  logic b,
    input  logic cin,

    output logic sum,
    output logic cout

);

    always @(*) begin

        sum  = a ^ b ^ cin;

        cout = (a & b) |
               (b & cin) |
               (cin & a);

    end

endmodule
