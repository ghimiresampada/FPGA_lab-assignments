`timescale 1ns/1ps

module mux_n_tb;

    parameter N = 8;

    reg  [N-1:0] a, b;
    reg          sel;
    wire [N-1:0] y;

    integer errors = 0;

    // Instantiate the Device Under Test (DUT)
    mux_n #(.N(N)) dut (
        .a   (a),
        .b   (b),
        .sel (sel),
        .y   (y)
    );

    // Dump waveform for GTKWave
    initial begin
        $dumpfile("mux_n_tb.vcd");
        $dumpvars(0, mux_n_tb);
    end

    // Stimulus
    initial begin
        $display("=========================================================");
        $display(" time |   a(hex) |   b(hex) | sel |   y(hex) | expected | result");
        $display("=========================================================");

        a = 8'h00; b = 8'h00; sel = 0; #10; check();
        a = 8'hAA; b = 8'h55; sel = 0; #10; check();
        a = 8'hAA; b = 8'h55; sel = 1; #10; check();
        a = 8'hFF; b = 8'h0F; sel = 0; #10; check();
        a = 8'hFF; b = 8'h0F; sel = 1; #10; check();
        a = 8'h3C; b = 8'hC3; sel = 0; #10; check();
        a = 8'h3C; b = 8'hC3; sel = 1; #10; check();

        $display("=========================================================");
        if (errors == 0)
            $display(" ALL TEST CASES PASSED");
        else
            $display(" %0d TEST CASE(S) FAILED", errors);
        $display("=========================================================");

        #10 $finish;
    end

    task check;
        reg [N-1:0] expected;
        begin
            expected = sel ? b : a;
            $display(" %4t |   %h    |   %h    |  %b  |   %h    |   %h    |  %s",
                       $time, a, b, sel, y, expected,
                       (y === expected) ? "PASS" : "FAIL");
            if (y !== expected) errors = errors + 1;
        end
    endtask

endmodule