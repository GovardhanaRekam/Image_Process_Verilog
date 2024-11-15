module tb_edgedetection;
    // Declare signals for the testbench
    reg clk;
    reg reset;
    wire [23:0] processed_pixel;  // Wire to capture output from the module

    // Instantiate the edge detection module
    image_processor uut (
        .clk(clk),
        .reset(reset),
        .processed_pixel(processed_pixel)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // Generate a clock signal with a period of 10ns
    end

    // Test sequence
    initial begin
        // Apply reset
        $display("Applying reset...");
        reset = 1;
        #20;
        reset = 0;  // Release reset
        $display("Reset released.");

        // Wait for the image processing to complete
        // We will use a time delay here, but ideally, you could check for completion signals or pixel processing status
        #1000000;  // Adjust the delay based on the size of the image and clock speed

        // After processing, check or save the output (processed_pixel)
        $finish;  // End simulation
    end

    // Monitor the processed pixel output
    initial begin
        // Print out the processed pixel value and time step for debugging purposes
        $monitor("Time: %0dns, Processed Pixel: %h", $time, processed_pixel);
    end

    // Debugging: Optionally, track the internal signal "i" for image processing in the "image_processor" module
    initial begin
        $display("Starting simulation...");
        #0;  // Initial time
        // Optionally, add a check for the value of "i" or other internal signals
        // This assumes there is an internal variable "i" in your image_processor module that tracks the image index
        $monitor("i = %d", uut.i);  // You can adjust based on your internal variable name
    end
endmodule
