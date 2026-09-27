`ifndef TEST_V
`define TEST_V

`include "environment.v"


class test;

    environment env;


    function new(virtual fa v_fa);

        env = new(v_fa);

    endfunction


    task run();

        env.run();

    endtask

endclass

`endif


/*
`include "environment.v"
`include "interface.v"

class test;

    environment env;

    virtual fa v_fa;

    // Constructor
    function new(virtual fa v_fa);

        this.v_fa = v_fa;

        // Create environment
        env = new(v_fa);

    endfunction


    // Start test
    task run();

        env.run();

    endtask

endclass
*/
