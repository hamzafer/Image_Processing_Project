% Segmentation

img_path = 'image_gs.png';

% Call the function to convert the image to grayscale
img = convertToGrayscale(inputImagePath);

% Perform segmentation
segmented = performImageSegmentation(img);

% Display the original and segmented images
figure;

% Original image
subplot(1, 3, 1);
imshow(img);
title('Original Image');

% Segmented image
subplot(1, 3, 2);
imshow(segmented);
title('Segmented Image');

% Histogram of the original image using histogramCalc
subplot(1, 3, 3);
calculateHistogram(img);
title('Histogram of Original Image');
hold on;
yl = ylim; % Get the y-axis limits
line([80, 80], yl, 'Color', 'r', 'LineStyle', '--'); % First cutoff
line([110, 110], yl, 'Color', 'r', 'LineStyle', '--'); % Second cutoff
hold off;
