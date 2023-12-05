% Define the file path for the input image
input_image_path = 'image_gs.png';

% Call the function to convert the image to grayscale
grayscale_image = convertToGrayscale(input_image_path);

% Read and process the original image
original_image = imread("week1_original.png"); % Read the original image
original_image_gray = rgb2gray(original_image); % Convert to grayscale

% Process the input image
if size(grayscale_image, 3) == 3 % Check if the provided image is color
    grayscale_image = rgb2gray(grayscale_image); % Convert to grayscale
end

% Histogram matching
matched_image1 = histogramMatching(grayscale_image, original_image_gray, true); % Match to the original histogram

% Create a random histogram
random_histogram = rand(256, 1);
matched_image2 = histogramMatching(grayscale_image, floor(random_histogram*255), false); % Match to the random histogram

% Plotting
% Original Image and Histogram
figure;
subplot(2, 2, 1);
imshow(original_image);
title('Original Image');
subplot(2, 2, 2);
bar(calculateHistogram(original_image_gray)); % Using histogramCalc for histogram
title('Histogram of Original Image');

% Target Image and Histogram
subplot(2, 2, 3);
imshow(grayscale_image);
title('Target Image');
subplot(2, 2, 4);
bar(calculateHistogram(grayscale_image)); % Using histogramCalc for histogram
title('Histogram of Target Image');

% Matched Image and Histogram (to Original)
figure;
subplot(1, 2, 1);
imshow(matched_image1);
title('Image Matched to Original Histogram');
subplot(1, 2, 2);
bar(calculateHistogram(matched_image1)); % Using histogramCalc for histogram
title('Histogram of Matched Image (Original)');

% Matched Image and Histogram (to Random)
figure;
subplot(1, 2, 1);
imshow(matched_image2);
title('Image Matched to Random Histogram');
subplot(1, 2, 2);
bar(calculateHistogram(matched_image2)); % Using histogramCalc for histogram
title('Histogram of Matched Image (Random)');
