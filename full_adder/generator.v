`ifndef GENERATOR_V
`define GENERATOR_V

`include "transaction.v"

class generator;

    transaction tr;

    mailbox #(transaction) mbx;

    event drive_done;


    function new(
        mailbox #(transaction) mbx,
        event drive_done
    );

        this.mbx        = mbx;
        this.drive_done = drive_done;

    endfunction


    task run();

        repeat (20) begin

            tr = new();

            assert(tr.randomize());

            tr.calculate();

            $display(
                "Generator: a=%0d b=%0d cin=%0d",
                tr.a,
                tr.b,
                tr.cin
            );

            mbx.put(tr);

            // Wait for driver to finish this transaction
            @drive_done;

        end

    endtask

endclass

`endif




/*
`include "transaction.v"

class generator;

    transaction tr;
    mailbox mbx;

    function new(mailbox mbx);
        this.mbx = mbx;
    endfunction

    task run();
        repeat (10) begin

            tr = new();

            assert(tr.randomize());

            mbx.put(tr);
  $display("Generator: a=%0d b=%0d cin=%0d sum=%0d cout=%0d",
                     tr.a, tr.b, tr.cin, tr.sum, tr.cout);	
        end
    endtask

endclass


*/









/*
The Generator creates transactions and sends them to the Driver.

With mailbox Proper communication between Generator and Driver

*/
