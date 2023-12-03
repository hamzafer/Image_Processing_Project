% Path to the image file
imagePath = 'image_gs.png';

% Call the converttToGrayscale function
% Step 1: Load your 256x256 grayscale image
grayscale_matrix = convertToGrayscale(imagePath);

% Define the quantization matrix
quantization_matrix = [
    16, 11, 10, 16, 24, 40, 51, 61;
    12, 12, 14, 19, 26, 58, 60, 55;
    14, 13, 16, 24, 40, 57, 69, 56;
    14, 17, 22, 29, 51, 87, 80, 62;
    18, 22, 37, 56, 68, 109, 103, 77;
    24, 35, 55, 64, 81, 104, 113, 92;
    49, 64, 78, 87, 103, 121, 120, 101;
    72, 92, 95, 98, 112, 100, 103, 99
];

% Step 2: Subtract 128 from each pixel value
grayscale_matrix = grayscale_matrix - 128;

% Step 4: Create and store 1024 (each of 8x8) blocks
processed_blocks = zeros(size(grayscale_matrix));

% Before going block to block through the matrix, we have to initialize the previous DC coefficient.
dcAnt = 0;
jpeg_coded = char.empty;

% Process each 8x8 block
for row = 1:8:256
    for col = 1:8:256
        % Calculating block indices
        i = (row - 1) / 8 + 1;
        j = (col - 1) / 8 + 1;

        % Step 3: Segment image in 8 × 8 blocks
        block = grayscale_matrix(row:row+7, col:col+7);

        % Step 5: Compute DCT of each block
        block_dct = dct2(block);

        % Step 6: Perform Quantization
        % Step 7: Round your answers
        quantized_block = round(block_dct ./ quantization_matrix);

        % Step 8: Zig-zag scanning
        seqCoef = zigzag(quantized_block);

        % Step 9: Differential coding
        % DC value:
        dif = seqCoef(1) - dcAnt;

        % Encoding DC: DPCM
        codeDC = codifDC(dif);

        % Encoding AC: in [(r,s), c] pattern
        codeAC = codifAC(seqCoef);

        % Updating jpeg_coded bitstream with the current codeBlock.
        codeBlock = [codeDC codeAC];
        jpeg_coded = [jpeg_coded codeBlock];

        % Updating the previous DC coefficient.
        dcAnt = seqCoef(1);

        % Store the processed block
        coded{i,j} = codeBlock;
    end
end

