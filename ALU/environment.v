
`ifndef ENVIRONMENT_V
`define ENVIRONMENT_V

`include "transaction.v"
`include "generator.v"
`include "driver.v"
`include "monitor.v"
`include "scoreboard.v"
`include "interface.v"


class environment;

    mailbox #(transaction) g2d;
    mailbox #(transaction) m2s;

    generator  gen;
    driver     drv;
    monitor    mon;
    scoreboard sb;

    virtual alu vif;

    event drive_done;


    function new(virtual alu vif);

        this.vif = vif;

        g2d = new();
        m2s = new();

        gen = new(g2d);

        drv = new(g2d, vif, drive_done);

        mon = new(m2s, vif, drive_done);

        sb = new(m2s);

    endfunction


    task run();

        fork
            gen.run();
            drv.run();
            mon.run();
            sb.run();
        join

    endtask

endclass

`endif


