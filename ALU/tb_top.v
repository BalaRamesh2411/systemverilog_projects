
`ifndef TB_TOP_V
`define TB_TOP_V

`include "interface.v"
`include "test.v"
`include "alu_8bit.v"


module tb_top;

    // Interface instance
    alu f();


    // DUT instance
    alu_8bit dut (
        .A        (f.A),
        .B        (f.B),
        .ALU_Sel  (f.ALU_Sel),
        .ALU_Out  (f.ALU_Out),
        .CarryOut (f.CarryOut)
    );


    // Test
    test t;


    // Start test
    initial begin

        t = new(f);

        t.run();

    end

endmodule

`endif


