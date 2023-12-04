% Uniform quantization

% Load an image
image = imread('color.JPEG');

% Determine the number of colors for quantization
num_colors_list = [2, 4, 8, 16, 32];

% Determine the number of rows and columns for subplots
numRows = 2; % Number of rows
numCols = 3; % Number of columns per row

% Create a figure for subplots
figure;

% Display the original image in the first subplot
subplot(numRows, numCols, 1);
imshow(image);
title('Original Image');
axis off;

% Loop through different numbers of quantized colors
for i = 1:length(num_colors_list)
    num_colors = num_colors_list(i);

    % Perform uniform quantization
    quantized_image = floor(double(image) / (256 / num_colors)) * (256 / num_colors);

    % Determine the row and column for the current subplot
    row = ceil(i / numCols);
    col = mod(i - 1, numCols) + 1;

    % Create a subplot for the current quantized image
    subplot(numRows, numCols, (row - 1) * numCols + col + 1);
    imshow(uint8(quantized_image));
    title(['Quantized Image (' num2str(num_colors) ' colors)']);
    axis off;
end
