from struct import pack

def mem_to_bmp(mem_file, output_bmp_file, width=640, height=426):
    # Open the mem file to read the pixel data
    with open(mem_file, 'r') as mem:
        pixel_data = mem.readlines()

    # BMP file headers (54 bytes for a standard BMP header)
    bmp_header = bytearray([
        0x42, 0x4D,           # Signature 'BM'
        0, 0, 0, 0,           # File size in bytes (will fill in later)
        0, 0,                 # Reserved
        0, 0,                 # Reserved
        54, 0, 0, 0,          # Offset to pixel data (54 bytes)
        40, 0, 0, 0,          # Info header size (40 bytes)
        width & 0xFF, (width >> 8) & 0xFF, (width >> 16) & 0xFF, (width >> 24) & 0xFF,  # Width
        height & 0xFF, (height >> 8) & 0xFF, (height >> 16) & 0xFF, (height >> 24) & 0xFF, # Height
        1, 0,                 # Planes (always 1)
        24, 0,                # Bits per pixel (24-bit = 3 bytes per pixel)
        0, 0, 0, 0,           # Compression (no compression)
        0, 0, 0, 0,           # Image size (can be 0 for uncompressed images)
        0x13, 0x0B, 0, 0,     # Horizontal resolution (2835 pixels/meter)
        0x13, 0x0B, 0, 0,     # Vertical resolution (2835 pixels/meter)
        0, 0, 0, 0,           # Number of colors in palette (0 = default 2^n)
        0, 0, 0, 0            # Important colors (0 = all)
    ])

    # Pixel array for BMP
    pixel_array = bytearray()

    # Convert each hex value back to RGB and add to pixel array
    for line in pixel_data:
        hex_value = line.strip()
        if len(hex_value) == 6:
            r = int(hex_value[0:2], 16)
            g = int(hex_value[2:4], 16)
            b = int(hex_value[4:6], 16)
            pixel_array.extend([b, g, r])  # BMP stores pixels in BGR format

    # BMP padding: BMP lines are padded to multiples of 4 bytes
    padding_size = (4 - (width * 3) % 4) % 4
    for row in range(height):
        start = row * width * 3
        end = start + width * 3
        pixel_array[start:end] += bytearray(padding_size)

    # Calculate total file size and update in header
    file_size = 54 + len(pixel_array)
    bmp_header[2:6] = pack('<I', file_size)  # Little-endian

    # Write the BMP header and pixel data to the output file
    with open(output_bmp_file, 'wb') as bmp:
        bmp.write(bmp_header)
        bmp.write(pixel_array)

# Usage
#mem_to_bmp('pixel_data.mem', 'output_image.bmp')
# Convert the processed .mem file to a BMP image
#mem_to_bmp('processed_pixel_data.mem', 'grayscale_image.bmp', width=640, height=426)
mem_to_bmp('processed_edg_pixel_data.mem', 'edg_det_image.bmp', width=640, height=426)
