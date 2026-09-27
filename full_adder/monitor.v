`ifndef MONITOR_V
`define MONITOR_V

`include "transaction.v"
`include "interface.v"

class monitor;

    transaction tr;

    mailbox #(transaction) mbx;

    virtual fa v_fa;

    event drive_done;


    function new(
        mailbox #(transaction) mbx,
        virtual fa v_fa,
        event drive_done
    );

        this.mbx        = mbx;
        this.v_fa       = v_fa;
        this.drive_done = drive_done;

    endfunction


    task run();

        repeat (20) begin

            // Wait for Driver
            @drive_done;

            tr = new();

            tr.a   = v_fa.a;
            tr.b   = v_fa.b;
            tr.cin = v_fa.cin;

            tr.sum  = v_fa.sum;
            tr.cout = v_fa.cout;

// =========================
            // ASSERTION
            // =========================

            assert ({v_fa.cout, v_fa.sum} ==
                    (v_fa.a + v_fa.b + v_fa.cin))
            else
                $error(
                    "ASSERTION FAILED: a=%0d b=%0d cin=%0d sum=%0d cout=%0d",
                    v_fa.a,
                    v_fa.b,
                    v_fa.cin,
                    v_fa.sum,
                    v_fa.cout
                );

    
		$display(
                "Monitor: a=%0d b=%0d cin=%0d sum=%0d cout=%0d",
                tr.a,
                tr.b,
                tr.cin,
                tr.sum,
                tr.cout
            );

            mbx.put(tr);

        end

    endtask

endclass

`endif
 
 
 
 


/*
`include "transaction.v"
`include "interface.v"



class monitor;

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

            #1;

            tr = new();

            tr.a    = v_fa.a;
            tr.b    = v_fa.b;
            tr.cin  = v_fa.cin;
            tr.sum  = v_fa.sum;
            tr.cout = v_fa.cout;

            $display("Monitor: a=%0d b=%0d cin=%0d sum=%0d cout=%0d",
                     tr.a, tr.b, tr.cin, tr.sum, tr.cout);

            // Send observed transaction to scoreboard
            mbx.put(tr);

        end

    endtask

endclass
*/

/*

The Monitor observes the DUT signals through the interface and collects them into a transaction.

The Driver sends data to the DUT.
The Monitor observes data from the DUT.

With mailbox When you introduce a Scoreboard, the Monitor needs to send the observed transaction to the Scoreboard

forever loop has no timing/event control. Because your Full Adder is combinational, the monitor can run continuously at the same simulation time and create a huge number of transactions.
*/
