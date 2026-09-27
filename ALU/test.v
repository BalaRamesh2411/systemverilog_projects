
`ifndef TEST_V
`define TEST_V

`include "environment.v"

class test;

    environment env;

    virtual alu vif;


    // Constructor
    function new(virtual alu vif);

        this.vif = vif;

        // Create environment
        env = new(vif);

    endfunction


    // Run test
    task run();

        env.run();

    endtask

endclass

`endif

