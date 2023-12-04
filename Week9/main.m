% Path to the grayscale image file
grayscaleImagePath = 'image_gs.png';

% Step 1: Load your 256x256 grayscale image
grayscaleImage = convertToGrayscale(grayscaleImagePath);

% Define the JPEG quantization matrix
jpegQuantMatrix = [
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
normalizedImage = grayscaleImage - 128;

% Step 4: Create and store 1024 (each of 8x8) blocks
dctQuantizedBlocks = zeros(size(normalizedImage));

% Initialize the previous DC coefficient
previousDC = 0;

% Initialize a 1D array to store DC differences
dcDifferences = [];

% Initialize a 2D list to store AC blocks
encodedBlocks = {};

% Process each 8x8 block
for row = 1:8:256
    for col = 1:8:256
        % Step 3: Segment image in 8 × 8 blocks
        block = normalizedImage(row:row+7, col:col+7);

        % Step 5: Compute DCT of each block
        dctBlock = dct2(block);

        % Step 6: Perform Quantization
        % Step 7: Round your answers
        quantizedBlock = round(dctBlock ./ jpegQuantMatrix);

        % Step 8: Zig-zag scanning
        zigzagSequence = zigzagScan(quantizedBlock);

        % Step 9: Differential coding
        % Step 9.A: Encoding DC: DPCM
        dcDiff = zigzagSequence(1) - previousDC;
        dcDifferences(end + 1) = dcDiff;

        % Step 9.A: Update the previous DC coefficient
        previousDC = zigzagSequence(1);

        % Step 9.B: Encoding AC: in [(r,s), c] pattern
        encodedBlock = encodeCoefficients(zigzagSequence);
        encodedBlocks{end+1} = encodedBlock;

        % Store the Quantization encoded block data
        dctQuantizedBlocks(row:row+7, col:col+7) = quantizedBlock;
    end
end
