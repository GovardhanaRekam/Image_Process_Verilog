/*module image_processor (
    input clk,          // Clock signal
    input reset,        // Reset signal
    output reg [23:0] processed_pixel   // Processed pixel data output (RRGGBB)
);

    // Memory to store the image data (size based on the resolution of the image)
    reg [23:0] image_mem [0:272639];  // 640x426 = 272640 pixels (24-bit color per pixel)

    integer i;

    initial begin
        // Load the pixel data from pixel_data.mem into the image_mem array
        $readmemh("pixel_data.mem", image_mem);
    end

    // Grayscale conversion algorithm
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            i <= 0;
        end else begin
            if (i < 272640) begin
                // Read pixel value (24-bit RGB)
                reg [7:0] R = image_mem[i][23:16];
                reg [7:0] G = image_mem[i][15:8];
                reg [7:0] B = image_mem[i][7:0];

                // Grayscale conversion: Y = 0.299*R + 0.587*G + 0.114*B
                reg [7:0] grayscale = (R * 30 + G * 59 + B * 11) / 100;

                // Store the grayscale pixel back into the memory (same R, G, B values)
                image_mem[i] <= {grayscale, grayscale, grayscale};
                processed_pixel <= {grayscale, grayscale, grayscale};

                i <= i + 1;
            end
        end
    end

    // Store the processed pixel data back into a .mem file
    initial begin
        $writememh("processed_pixel_data.mem", image_mem);  // Save processed image data
    end

endmodule
*/

































module image_processor (
    input clk,          // Clock signal
    input reset,        // Reset signal
    output reg [23:0] processed_pixel   // Processed pixel data output (RRGGBB)
);

    // Memory to store the image data (size based on the resolution of the image)
    reg [23:0] image_mem [0:272639];  // 640x426 = 272640 pixels (24-bit color per pixel)
    integer i;

    // Declare variables to store pixel components
    reg [7:0] R, G, B;
    reg [7:0] grayscale;

    initial begin
        // Load the pixel data from pixel_data.mem into the image_mem array
        $readmemh("pixel_data.mem", image_mem);
        i = 0;  // Initialize the index
    end

    // Grayscale conversion algorithm
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            i <= 0;
        end else begin
            if (i < 272640) begin
                // Read pixel value (24-bit RGB)
                R = image_mem[i][23:16];
                G = image_mem[i][15:8];
                B = image_mem[i][7:0];

                // Grayscale conversion: Y = 0.299*R + 0.587*G + 0.114*B
                grayscale = (R * 30 + G * 59 + B * 11) / 100;

                // Store the grayscale pixel back into the memory (same R, G, B values)
                image_mem[i] <= {grayscale, grayscale, grayscale};
                processed_pixel <= {grayscale, grayscale, grayscale};

                i <= i + 1;
            end
        end
    end

    // Store the processed pixel data back into a .mem file when done
    initial begin
        $writememh("processed_pixel_data.mem", image_mem);  // Save processed image data
    end

endmodule

