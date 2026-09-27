`ifndef TRANSACTION_V
`define TRANSACTION_V

class transaction;

    // DUT inputs
    rand logic a;
    rand logic b;
    rand logic cin;

    // Expected outputs
    logic exp_sum;
    logic exp_cout;

    // Actual DUT outputs
    logic sum;
    logic cout;

    function void calculate();

        {exp_cout, exp_sum} = a + b + cin;

    endfunction

endclass

`endif




/*

class transaction;

    rand logic a;
    rand logic b;
    rand logic cin;

    logic sum;
    logic cout;

endclass

*/





/*

transaction is a class object that represents one complete test case or one data transfer between testbench components.

The transaction class is used to store one test case (one set of inputs and outputs) in the SystemVerilog testbench.
*/
