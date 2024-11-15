module image_processor (
    input clk,          // Clock signal
    input reset,        // Reset signal
    output reg [23:0] processed_pixel   // Processed pixel data output (RRGGBB)
);

    // Memory to store the image data (size based on the resolution of the image)
    reg [23:0] image_mem [0:272639];  // 640x426 = 272640 pixels (24-bit color per pixel)
    reg [23:0] temp_mem [0:272639];   // Temporary memory to store edge-detected data

    integer i, x, y;

    initial begin
        // Load the pixel data from pixel_data.mem into the image_mem array
        $readmemh("pixel_data.mem", image_mem);
    end

    // Sobel operator variables
    reg signed [10:0] sobel_x, sobel_y;
    reg [7:0] edge_strength;
    reg [23:0] top_left, top, top_right;
    reg [23:0] left, right;
    reg [23:0] bottom_left, bottom, bottom_right;

    // Edge detection algorithm using Sobel operator
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            i <= 0;
        end else begin
            for (y = 1; y < 425; y = y + 1) begin  // Loop over the height (excluding borders)
                for (x = 1; x < 639; x = x + 1) begin  // Loop over the width (excluding borders)
                    // Calculate indices for the 3x3 neighborhood
                    top_left     = image_mem[(y-1)*640 + (x-1)];
                    top          = image_mem[(y-1)*640 + x];
                    top_right    = image_mem[(y-1)*640 + (x+1)];
                    left         = image_mem[y*640 + (x-1)];
                    right        = image_mem[y*640 + (x+1)];
                    bottom_left  = image_mem[(y+1)*640 + (x-1)];
                    bottom       = image_mem[(y+1)*640 + x];
                    bottom_right = image_mem[(y+1)*640 + (x+1)];

                    // Apply Sobel operator in X-direction
                    sobel_x = (-1)*top_left[23:16] + (1)*top_right[23:16]
                              + (-2)*left[23:16]   + (2)*right[23:16]
                              + (-1)*bottom_left[23:16] + (1)*bottom_right[23:16];

                    // Apply Sobel operator in Y-direction
                    sobel_y = (-1)*top_left[23:16] + (-2)*top[23:16] + (-1)*top_right[23:16]
                              + (1)*bottom_left[23:16] + (2)*bottom[23:16] + (1)*bottom_right[23:16];

                    // Compute gradient magnitude (approximated)
                    if (sobel_x < 0)
                        sobel_x = -sobel_x;

                    if (sobel_y < 0)
                        sobel_y = -sobel_y;

                    edge_strength = sobel_x + sobel_y;

                    // Apply a threshold to detect edges
                    if (edge_strength > 8'h80) begin  // Adjust threshold value as needed
                        temp_mem[y*640 + x] <= 24'hFFFFFF;  // Edge (white)
                    end else begin
                        temp_mem[y*640 + x] <= 24'h000000;  // Non-edge (black)
                    end
                end
            end
            // Update the processed pixel output (just for display/debugging purposes)
            processed_pixel <= temp_mem[i];
            i <= i + 1;

            // Store the processed pixel data back into the memory after the loop
            $writememh("processed_edg_pixel_data.mem", temp_mem);  // Save processed image data
        end
    end

endmodule

