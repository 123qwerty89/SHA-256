
module tb_sha256_compact;
    reg clk, rst_n;
    reg start_tb;           // Testbench-controlled start signal
    reg start_force_en;     // Enable signal for force control
    reg [511:0] block;
    wire [255:0] digest;
    wire ready;
    
    // Multiplexed start signal - can be controlled by testbench or force
    wire start = start_force_en ? start_tb : start_tb;
    
    sha256_compact uut (
        .clk(clk), 
        .rst_n(rst_n), 
        .start(start),          // This can be overridden by force constant
        .block(block), 
        .digest(digest), 
        .ready(ready)
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk;   // 100MHz clock (10ns period)

    // Testbench control sequence
    initial begin
        // Initialize signals
        rst_n = 0;
        start_tb = 0;
        start_force_en = 0;
        block = 0;
        
        // Display simulation start
        $display("=== SHA256 Simulation Started ===");
        $display("Time: %0t", $time);
        
        // Reset sequence
        #20 rst_n = 1;
        $display("Reset deasserted at time: %0t", $time);
        #20;

        // Set up input block - Padded "abc" for SHA256
        block = 512'h61626380000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000018;
        $display("Block loaded at time: %0t", $time);
        $display("Block = %h", block);

        // Option 1: Testbench-controlled start
        $display("\n=== Method 1: Testbench Control ===");
        @(posedge clk);
        start_tb = 1;
        $display("Start asserted by testbench at time: %0t", $time);
        @(posedge clk);
        start_tb = 0;
        $display("Start deasserted by testbench at time: %0t", $time);

        // Wait for completion
        wait (ready);
        $display("First hash completed at time: %0t", $time);
        $display("Digest = %h", digest);
        
        // Wait some time before next test
        #100;
        
        // Option 2: Force constant control setup
        $display("\n=== Method 2: Force Constant Ready ===");
        $display("You can now use force constant on 'start' signal");
        $display("In Vivado: Right-click on 'start' -> Force Constant");
        $display("Command line: add_force /tb_sha256_compact/start 1 +10ns -cancel_after +20ns");
        
        // Enable monitoring for force control
        start_force_en = 1;
        
        // Wait for potential force operations
        #1000;
        
        $display("\n=== Simulation Complete ===");
        $finish;
    end
    
    // Monitor for debugging
    always @(posedge start) begin
        $display("START detected at time: %0t", $time);
    end
    
    always @(posedge ready) begin
        $display("READY asserted at time: %0t", $time);
        $display("Final Digest = %h", digest);
    end
    
    // Additional test scenarios
    initial begin
        // Wait for initial test to complete
        #2000;
        
        // Test scenario with different block
        if (!$test$plusargs("skip_second_test")) begin
            $display("\n=== Second Test Block ===");
            
            // Wait for idle state
            wait (!ready);
            #50;
            
            // Load different test data
            block = 512'h80000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
            
            @(posedge clk);
            start_tb = 1;
            @(posedge clk);
            start_tb = 0;
            
            wait (ready);
            $display("Second test completed. Digest = %h", digest);
        end
    end

endmodule
