
`ifndef DRIVER_V
`define DRIVER_V

`include "transaction.v"

class driver;

    transaction tr;

    mailbox #(transaction) g2d;

    virtual alu vif;

    event drive_done;


    // Constructor
    function new(
        mailbox #(transaction) g2d,
        virtual alu vif,
        event drive_done
    );

        this.g2d        = g2d;
        this.vif        = vif;
        this.drive_done = drive_done;

    endfunction


    // Driver task
 task run();

    repeat (20) begin

        g2d.get(tr);

        vif.A       = tr.A;
        vif.B       = tr.B;
        vif.ALU_Sel = tr.ALU_Sel;

        $display(
            "DRIVER: A=%0d B=%0d ALU_Sel=%0d",
            tr.A, tr.B, tr.ALU_Sel
        );

        #1;

        -> drive_done;

    end

endtask

endclass

`endif




/*
g2d.get(tr)
     ↓
Drive A, B, ALU_Sel
     ↓
#1
     ↓
-> drive_done
     ↓
"Driver finished"
*/
