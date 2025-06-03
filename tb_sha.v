module tb_sha256_compact;
    reg clk, rst_n, start;
    reg [511:0] block;
    wire [255:0] digest;
    wire ready;

    sha256_compact uut (
        .clk(clk), .rst_n(rst_n), .start(start),
        .block(block), .digest(digest), .ready(ready)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        rst_n = 0;
        start = 0;
        block = 0;
        #20 rst_n = 1;
        #20;

        // Padded block for "abc"
        block = 512'h61626380000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000018;

        @(posedge clk);
        start = 1;
        @(posedge clk);
        start = 0;

        wait (ready);
        $display("Digest = %h", digest);
        #20;
        $finish;
    end
endmodule
