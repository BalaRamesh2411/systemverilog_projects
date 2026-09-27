
`ifndef DRIVER_V
`define DRIVER_V


`include "transaction.v"
`include "interface.v"

class driver;

    transaction tr;

    mailbox #(transaction) mbx;

    virtual fa v_fa;

    event drive_done;

    function new(
        mailbox #(transaction) mbx,
        virtual fa v_fa,
        event drive_done
    );

        this.mbx = mbx;
        this.v_fa = v_fa;
        this.drive_done = drive_done;

    endfunction

    task run();

        forever begin

            mbx.get(tr);

            v_fa.a   = tr.a;
            v_fa.b   = tr.b;
            v_fa.cin = tr.cin;

            $display(
                "Driver: a=%0d b=%0d cin=%0d",
                v_fa.a, v_fa.b, v_fa.cin
            );

            // Allow combinational DUT to calculate
            #1;

            -> drive_done;

        end

    endtask

endclass

`endif


/*
`include "transaction.v"
`include "interface.v"

class driver;

    transaction tr;
    mailbox #(transaction) mbx;
    virtual fa v_fa;

    function new(mailbox #(transaction) mbx,
                 virtual fa v_fa);

        this.mbx  = mbx;
        this.v_fa = v_fa;

    endfunction

    task run();

        forever begin

            // Get transaction from mailbox
            mbx.get(tr);

            // Drive inputs to DUT
            v_fa.a   = tr.a;
            v_fa.b   = tr.b;
            v_fa.cin = tr.cin;

            $display("Driver: a=%0d b=%0d cin=%0d",
                     tr.a, tr.b, tr.cin);

        end

    endtask

endclass
*/

/*
The Driver takes a transaction from the Generator through the mailbox and converts that transaction into actual DUT input signals.

*/
