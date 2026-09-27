
`ifndef GENERATOR_V
`define GENERATOR_V

`include "transaction.v"

class generator;

    transaction tr;
    mailbox #(transaction) g2d;


    // Constructor
    function new(mailbox #(transaction) g2d);

        this.g2d = g2d;

    endfunction


    // Generator task
    task run();

        repeat (20) begin

            // Create a new transaction
            tr = new();

            // Randomize inputs
            if (!tr.randomize())
                $display("GENERATOR: Randomization failed");
            else
                $display(
                    "GENERATOR: A=%0d B=%0d ALU_Sel=%0d",
                    tr.A,
                    tr.B,
                    tr.ALU_Sel
                );

            // Send transaction to driver
            g2d.put(tr);

        end

    endtask

endclass

`endif
