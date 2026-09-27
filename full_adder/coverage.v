`ifndef COVERAGE_V
`define COVERAGE_V

class coverage;

    virtual fa v_fa;

    event drive_done;


    covergroup fa_coverage;

        cp_a: coverpoint v_fa.a;

        cp_b: coverpoint v_fa.b;

        cp_cin: coverpoint v_fa.cin;

        cross_inputs: cross cp_a, cp_b, cp_cin;

    endgroup


    function new(
        virtual fa v_fa,
        event drive_done
    );

        this.v_fa = v_fa;
        this.drive_done = drive_done;

        fa_coverage = new();

    endfunction


    task run();

        repeat (20) begin

            @drive_done;

            fa_coverage.sample();

        end

    endtask

endclass

`endif
