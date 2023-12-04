% Dithering

% Load the input image
input_image = imread('color.JPEG');

% Convert the image to double precision in the range [0, 1]
input_image = im2double(input_image);

% Initialize the number of quantized colors
num_colors_list = [2, 4, 8, 16, 32];

% Determine the number of rows and columns for subplots
numRows = 2; % Number of rows
numCols = 3; % Number of columns per row

% Create a figure for subplots
figure;

% Display the original image in the first subplot
subplot(numRows, numCols, 1);
imshow(input_image);
title('Original Image');

% Loop through different numbers of quantized colors
for i = 1:length(num_colors_list)
    num_colors = num_colors_list(i);

    % Perform color quantization using rgb2ind with dithering
    [quantized_index_image, color_map] = rgb2ind(input_image, num_colors, 'dither');

    % Convert the quantized image back to RGB using the color map
    quantized_rgb_image = ind2rgb(quantized_index_image, color_map);

    % Determine the row and column for the current subplot
    row = ceil((i+1) / numCols);
    col = mod(i, numCols) + 1;

    % Create a subplot for the current quantized image
    subplot(numRows, numCols, (row - 1) * numCols + col);
    imshow(quantized_rgb_image);
    title(['Quantized Image (' num2str(num_colors) ' colors)']);
end
