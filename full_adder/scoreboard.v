
`ifndef SCOREBOARD_V
`define SCOREBOARD_V

`include "transaction.v"

class scoreboard;

    transaction tr;

    mailbox #(transaction) mbx;

    function new(mailbox #(transaction) mbx);

        this.mbx = mbx;

    endfunction

task run();

    repeat (20) begin

        mbx.get(tr);

        tr.calculate();

        if ((tr.sum == tr.exp_sum) &&
            (tr.cout == tr.exp_cout)) begin

            $display(
                "PASS: a=%0d b=%0d cin=%0d sum=%0d cout=%0d",
                tr.a,
                tr.b,
                tr.cin,
                tr.sum,
                tr.cout
            );

        end
        else begin

            $display(
                "FAIL: a=%0d b=%0d cin=%0d sum=%0d cout=%0d Expected sum=%0d cout=%0d",
                tr.a,
                tr.b,
                tr.cin,
                tr.sum,
                tr.cout,
                tr.exp_sum,
                tr.exp_cout
            );

        end

    end

endtask
endclass

`endif



/*
`include "transaction.v"

class scoreboard;

    transaction tr;

    mailbox #(transaction) mbx;

    function new(mailbox #(transaction) mbx);
        this.mbx = mbx;
    endfunction

    task run();

        forever begin

            mbx.get(tr);

            if ({tr.cout, tr.sum} == (tr.a + tr.b + tr.cin)) begin

                $display("PASS: a=%0d b=%0d cin=%0d sum=%0d cout=%0d",
                         tr.a, tr.b, tr.cin, tr.sum, tr.cout);

            end
            else begin

                $display("FAIL: a=%0d b=%0d cin=%0d sum=%0d cout=%0d",
                         tr.a, tr.b, tr.cin, tr.sum, tr.cout);

            end

        end

    endtask

endclass
*/


/*
The Scoreboard checks whether the DUT output is correct or not. 
Scoreboard needs a way to receive the transaction from the Monitor.
*/
