`ifndef ENVIRONMENT_V
`define ENVIRONMENT_V

`include "generator.v"
`include "driver.v"
`include "monitor.v"
`include "scoreboard.v"
`include "coverage.v"

class environment;

    generator  gen;
    driver     drv;
    monitor    mon;
    scoreboard scb;
    coverage cov;


    mailbox #(transaction) gen2drv;
    mailbox #(transaction) mon2scb;


    virtual fa v_fa;

    event drive_done;


    function new(virtual fa v_fa);

        this.v_fa = v_fa;


        // Create mailboxes
        gen2drv = new();
        mon2scb = new();


        // Create components
        gen = new(
            gen2drv,
            drive_done
        );


        drv = new(
            gen2drv,
            v_fa,
            drive_done
        );


       mon = new(
    mon2scb,
    v_fa,
    drive_done
);


        scb = new(
            mon2scb
        );

	cov = new(
    v_fa,
    drive_done
);

    endfunction


    task run();

        fork

            gen.run();

            drv.run();

            mon.run();

            scb.run();

  cov.run();
	    

        join

    endtask

endclass

`endif

/*

`include "generator.v"
`include "driver.v"
`include "monitor.v"
`include "scoreboard.v"
`include "interface.v"




class environment;

    generator   gen;
    driver      drv;
    monitor     mon;
    scoreboard  scb;

    mailbox #(transaction) gen2drv;
    mailbox #(transaction) mon2scb;

    virtual fa v_fa;


    // Constructor
    function new(virtual fa v_fa);

        this.v_fa = v_fa;

        // Create mailboxes
        gen2drv = new();
        mon2scb = new();

        // Create components
        gen = new(gen2drv);
        drv = new(gen2drv, v_fa);
        mon = new(mon2scb, v_fa);
        scb = new(mon2scb);

    endfunction


    // Run all components
    task run();

        fork
            gen.run();
            drv.run();
            mon.run();
            scb.run();
        join_any

    endtask

endclass
*/
