# Image Processing with Verilog

This project demonstrates image processing using Verilog, where an image is processed for grayscale conversion and edge detection. The image is read from a `.bmp` file and processed using Verilog code. The processed data is stored in a `.mem` file and can be converted back to an image file.

## Project Overview 🖼️

The project performs two main image processing tasks:

1. **Grayscale Conversion**: Converts the input image to grayscale.
2. **Edge Detection**: Detects edges in the image using basic algorithms.

### Flow of the Project 🚀

1. **Input Image**: The image is first extracted from a `.bmp` file and stored in a `.mem` file.
2. **Verilog Processing**: The pixel data from the `.mem` file is processed in Verilog to perform grayscale conversion and edge detection.
3. **Output Image**: The processed image is then saved as a `.bmp` file.

## Input Image 📸

Here is the input image that is used in the project:

![Input Image](https://github.com/GovardhanaRekam/Image_Process_Verilog/blob/main/sample_640%C3%97426.bmp)

## Grayscale Output Image 🌑

After the grayscale conversion, the image looks like this:

![Grayscale Image](https://github.com/GovardhanaRekam/Image_Process_Verilog/blob/main/grayscale_image.bmp)

## Edge Detection Output Image 🔍

Edge detection applied to the input image results in this output:

![Edge Detection Image](https://github.com/GovardhanaRekam/Image_Process_Verilog/blob/main/edg_det_image.bmp)

## How It Works 🛠️

1. **Input Processing**: The image is read from a `.bmp` file and stored in a memory file (`pixel_data.mem`).
2. **Grayscale Conversion**: The RGB values of the pixels are converted to grayscale using the formula:  
   \[ Y = 0.299R + 0.587G + 0.114B \]
3. **Edge Detection**: The edge detection algorithm is applied on the grayscale image to identify edges.
4. **Output Generation**: After processing, the resulting pixel data is saved into a `.mem` file, and the image is converted back to `.bmp`.

## Files 📂

- **input image**: [sample_640x426.bmp](https://github.com/GovardhanaRekam/Image_Process_Verilog/blob/main/sample_640%C3%97426.bmp)
- **grayscale output**: [grayscale_image.bmp](https://github.com/GovardhanaRekam/Image_Process_Verilog/blob/main/grayscale_image.bmp)
- **edge detection output**: [edg_det_image.bmp](https://github.com/GovardhanaRekam/Image_Process_Verilog/blob/main/edg_det_image.bmp)

## How to Run the Project 🏃‍♂️

1. Clone the repository to your local machine:
   ```bash
   git clone https://github.com/GovardhanaRekam/Image_Process_Verilog.git2.

2.Make sure you have a Verilog simulator to run the code.

3.Run the Verilog simulation for image processing.

4.Check the processed output images generated in the repository.
