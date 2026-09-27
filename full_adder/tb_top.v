`include "interface.v"
`include "full_adder.v"

`include "transaction.v"
`include "generator.v"
`include "driver.v"
`include "monitor.v"
`include "scoreboard.v"
`include "environment.v"
`include "coverage.v"


module tb_top;

    // Interface
    fa f();


    // DUT
    full_adder dut(

        .a    (f.a),
        .b    (f.b),
        .cin  (f.cin),

        .sum  (f.sum),
        .cout (f.cout)

    );


    // Environment
    environment env;


    initial begin

        // Create environment
        env = new(f);

        // Start test
        env.run();

    end

endmodule



/*
`include "interface.v"
`include "full_adder.v"
`include "transaction.v"
`include "generator.v"
`include "driver.v"
`include "monitor.v"
`include "scoreboard.v"
`include "environment.v"
`include "test.v"

module tb_top;

    fa intf();

    full_adder dut (
        .a    (intf.a),
        .b    (intf.b),
        .cin  (intf.cin),
        .sum  (intf.sum),
        .cout (intf.cout)
    );

    test t;

    initial begin
        t = new(intf);
        t.run();

        #10;
        $finish;
    end

endmodule
*/
