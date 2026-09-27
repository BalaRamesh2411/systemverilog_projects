
`ifndef SCOREBOARD_V
`define SCOREBOARD_V

`include "transaction.v"

class scoreboard;

    transaction tr;

    mailbox #(transaction) mbx;


    // Constructor
    function new(mailbox #(transaction) mbx);

        this.mbx = mbx;

    endfunction


    // Scoreboard task
    task run();

        repeat (20) begin

            // Get transaction from monitor
            mbx.get(tr);

          tr.calculate();

if ((tr.ALU_Out === tr.exp_ALU_Out) &&
    (tr.CarryOut === tr.exp_CarryOut))begin

                $display(
                    "SCOREBOARD PASS: A=%0d B=%0d Sel=%0d Actual=%0d Expected=%0d Carry=%0d",
                    tr.A,
                    tr.B,
                    tr.ALU_Sel,
                    tr.ALU_Out,
                    tr.exp_ALU_Out,
                    tr.CarryOut
                );

            end
            else begin

                $error(
                    "SCOREBOARD FAIL: A=%0d B=%0d Sel=%0d Actual=%0d Expected=%0d ActualCarry=%0d ExpectedCarry=%0d",
                    tr.A,
                    tr.B,
                    tr.ALU_Sel,
                    tr.ALU_Out,
                    tr.exp_ALU_Out,
                    tr.CarryOut,
                    tr.exp_CarryOut
                );

            end

        end

    endtask

endclass

`endif

