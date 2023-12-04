% K Means

% Load the input image
inputImage = imread('color.JPEG');

% Convert the image to Lab color space
labImage = rgb2lab(inputImage);

% Reshape the Lab image into a 2D array
[m, n, ~] = size(labImage);
labData = reshape(labImage, m * n, 3);

% Specify different numbers of clusters to quantize to
numClustersList = [2, 4, 8, 16, 32];
numRows = 2; % Number of rows for subplots
numCols = 3; % Number of columns for subplots in each row

% Create a figure for subplots
figure;

% Display the original image in the first subplot
subplot(numRows, numCols, 1);
imshow(inputImage);
title('Original Image');

% Loop through different numbers of clusters
for i = 1:length(numClustersList)
    numClusters = numClustersList(i);

    % Perform K-means clustering
    [clusterIndices, clusterCenters] = kmeans(labData, numClusters);

    % Assign cluster centers to each pixel
    quantizedLabData = clusterCenters(clusterIndices, :);

    % Reshape the quantized Lab data back to the original image size
    quantizedLabImage = reshape(quantizedLabData, m, n, 3);

    % Convert the quantized Lab image back to RGB color space
    quantizedImage = lab2rgb(quantizedLabImage);

    % Determine the row and column for the current subplot
    row = ceil(i / numCols);
    col = mod(i - 1, numCols) + 1;

    % Create a subplot for the current quantized image
    subplot(numRows, numCols, (row - 1) * numCols + col + 1);
    imshow(quantizedImage);
    title(['Quantized Image with ', num2str(numClusters), ' Clusters']);
end
