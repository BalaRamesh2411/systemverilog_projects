
`ifndef MONITOR_V
`define MONITOR_V

`include "transaction.v"
`include "interface.v"

class monitor;

    transaction tr;

    mailbox #(transaction) mbx;

    virtual alu vif;

    event drive_done;


    // Constructor
    function new(
        mailbox #(transaction) mbx,
        virtual alu vif,
        event drive_done
    );

        this.mbx        = mbx;
        this.vif        = vif;
        this.drive_done = drive_done;

    endfunction


    // Monitor task
    task run();

        repeat (20) begin

            // Wait for driver
            @drive_done;

            // Allow combinational DUT to update
            #0;

            tr = new();

            // Capture inputs
            tr.A       = vif.A;
            tr.B       = vif.B;
            tr.ALU_Sel = vif.ALU_Sel;

            // Capture DUT outputs
            tr.ALU_Out  = vif.ALU_Out;
            tr.CarryOut = vif.CarryOut;

            $display(
                "MONITOR: A=%0d B=%0d Sel=%0d Out=%0d Carry=%0d",
                tr.A,
                tr.B,
                tr.ALU_Sel,
                tr.ALU_Out,
                tr.CarryOut
            );

            mbx.put(tr);

        end

    endtask

endclass

`endif

