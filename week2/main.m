% Define the file path for the input image
inputImagePath = 'image_gs.png';

% Call the function to convert the image to grayscale
grayscaleImage = convertToGrayscale(inputImagePath);

% Check if the image is initially in color
if size(grayscaleImage, 3) == 3
    % Convert the color image to grayscale
    grayscaleImage = rgb2gray(grayscaleImage);
end

% Calculate the histogram of the grayscale image
histogramData = calculateHistogram(grayscaleImage);

% Normalize the grayscale image
normalizedImage = normalizeImage(grayscaleImage);

% Perform histogram equalization on the grayscale image
equalizedImage = performHistogramEqualization(histogramData, normalizedImage, 8);

% Calculate difference images
differenceNormalized = imabsdiff(grayscaleImage, normalizedImage);
differenceEqualized = imabsdiff(grayscaleImage, equalizedImage);

% Create the first figure for the normalized image and its difference
figure;

subplot(1, 3, 1);
imshow(grayscaleImage);
title('Original Grayscale Image');

subplot(1, 3, 2);
imshow(normalizedImage);
title('Normalized Grayscale Image');

subplot(1, 3, 3);
imshow(differenceNormalized);
title('Difference from Original (Normalized)');

% Create the second figure for the equalized image and its difference
figure;

subplot(1, 3, 1);
imshow(grayscaleImage);
title('Original Grayscale Image');

subplot(1, 3, 2);
imshow(equalizedImage);
title('Histogram Equalized Grayscale Image');

subplot(1, 3, 3);
imshow(differenceEqualized);
title('Difference from Original (Equalized)');
