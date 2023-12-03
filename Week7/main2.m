% Path to the image file
imagePath = 'image_gs.png';

% Check if the file exists
if exist(imagePath, 'file') ~= 2
    error('Image file does not exist.');
end

% Call the convertToGrayscale function
grayImage = convertToGrayscale(imagePath);

% Initialize a new figure for displaying images
figure;

% Display the original grayscale image
subplot(2, 2, 1); % 2 rows, 2 columns, position 1
imagesc(grayImage);
title('Original Image');
colormap(gray); % Apply grayscale color map

%------------------------Haar Transform----------------------
haarImage = haarTransform(grayImage);
subplot(2, 2, 2); % 2 rows, 2 columns, position 2
imagesc(haarImage);
title('Haar Transform');
colormap(gray); % Apply grayscale color map

%------------------------Inverse Haar Transform----------------------
decompImage = inverseHaarTransform(haarImage);
subplot(2, 2, 3); % 2 rows, 2 columns, position 3
imagesc(decompImage);
title('Inverse Haar Transform');
colormap(gray); % Apply grayscale color map

% Calculate performance parameters
MSE = immse(grayImage, decompImage);
RMSE = sqrt(MSE);
PSNR = 10 * log10(256 * 256 / MSE);

% Plot MSE, RMSE, and PSNR in a single bar chart
subplot(2, 2, 4); % 2 rows, 2 columns, position 4
bar([MSE, RMSE, PSNR]);
set(gca, 'XTickLabel', {'MSE', 'RMSE', 'PSNR'}, 'XTick', 1:3);
ylabel('Error Values');
title('Error Metrics');

% Adjust layout to prevent label overlap
set(gcf, 'Position', get(0, 'Screensize')); % Maximize figure to fullscreen for readability
