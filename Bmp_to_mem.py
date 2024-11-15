'''
import struct

def parse_bmp_header(filename):
    with open(filename, 'rb') as bmp_file:
        # Read the file header (14 bytes)
        file_header = bmp_file.read(14)
        bfType, bfSize, bfReserved1, bfReserved2, bfOffBits = struct.unpack('<2sIHHI', file_header)
        
        # Ensure it's a BMP file by checking the bfType
        if bfType != b'BM':
            raise ValueError("Not a BMP file")
        
        # Read the DIB header (40 bytes for BITMAPINFOHEADER)
        dib_header = bmp_file.read(40)
        (biSize, biWidth, biHeight, biPlanes, biBitCount, biCompression, 
         biSizeImage, biXPelsPerMeter, biYPelsPerMeter, biClrUsed, biClrImportant) = struct.unpack('<IiiHHIIiiII', dib_header)
        
        print(f"Width: {biWidth} pixels")
        print(f"Height: {biHeight} pixels")
        print(f"Bit Depth: {biBitCount} bits per pixel")
        print(f"Offset to Pixel Data: {bfOffBits} bytes")
        
        # Seek to the pixel data
        bmp_file.seek(bfOffBits)
        
        # Depending on biBitCount, read pixel data (24-bit means RGB data)
        if biBitCount == 24:
            # Read the pixel data
            pixel_data = bmp_file.read(biWidth * biHeight * 3)  # Each pixel is 3 bytes (R, G, B)
            # You can further process the pixel_data as needed (store in array, etc.)
            
        return biWidth, biHeight, biBitCount, pixel_data

# Example usage:
width, height, bit_depth, pixel_data = parse_bmp_header('/home/amma/Downloads/sample_640×426.bmp')
'''
def save_pixel_data_to_mem(filename, output_mem_file):
    with open(filename, 'rb') as bmp_file:
        # Skip to pixel data using the offset you found (138 bytes)
        bmp_file.seek(138)
        
        # Open the output memory file to write the pixel data
        with open(output_mem_file, 'w') as mem_file:
            # Loop through the pixels (640x426 image, 24-bit BMP)
            for _ in range(426):  # height of image
                for _ in range(640):  # width of image
                    # Read 3 bytes (RGB) per pixel
                    pixel = bmp_file.read(3)
                    # Convert pixel to hexadecimal and write to .mem file
                    mem_file.write(f'{pixel[0]:02X}{pixel[1]:02X}{pixel[2]:02X}\n')

# Save the pixel data into a memory file
save_pixel_data_to_mem('/home/amma/Downloads/sample_640×426.bmp', 'pixel_data.mem')

