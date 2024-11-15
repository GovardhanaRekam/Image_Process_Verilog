module tb_img_process;
    reg clk;
    reg reset;
    wire [23:0] processed_pixel;

    // Instantiate the image_processor module
    image_processor uut (
        .clk(clk),
        .reset(reset),
        .processed_pixel(processed_pixel)
    );

    // Clock generation
    always begin
        #5 clk = ~clk;  // 10ns clock period (100MHz)
    end

    // Test sequence
    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;
        #10 reset = 0;  // De-assert reset after 10ns

        // Run simulation for a set period
        #10000 $finish;  // Stop simulation after 10,000ns
    end

    // Monitor the processed_pixel output
    initial begin
        $monitor("Time: %0dns, Processed Pixel: %h", $time, processed_pixel);
    end
endmodule
