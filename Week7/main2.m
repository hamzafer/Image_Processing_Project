% Path to the image file
imagePath = 'image_gs.png';
scalingFactor = 2;
% scalingFactor = sqrt(2);

% Call the convertToGrayscale function
grayImage = convertToGrayscale(imagePath);
grayImage = im2double(grayImage); % Convert image to double

% Initialize a new figure for displaying images
figure;

% Display the original grayscale image
subplot(2, 2, 1); % 2 rows, 2 columns, position 1
imagesc(grayImage);
title('Original Image');
colormap(gray); % Apply grayscale color map

%------------------------Haar Transform----------------------
haarImage = haarTransform(grayImage, scalingFactor);
subplot(2, 2, 2); % 2 rows, 2 columns, position 2
imagesc(haarImage);
title('Haar Transform');
colormap(gray); % Apply grayscale color map

%------------------------Inverse Haar Transform----------------------
decompImage = inverseHaarTransform(haarImage, scalingFactor);
subplot(2, 2, 3); % 2 rows, 2 columns, position 3
imagesc(decompImage);
title('Inverse Haar Transform');
colormap(gray); % Apply grayscale color map

% Calculate performance parameters
MSE = immse(grayImage, decompImage);
RMSE = sqrt(MSE);
PSNR = 10 * log10(256 * 256 / MSE);

fprintf('\n The Mean-Squared Error (MSE) is %f\n', MSE);
fprintf('\n The Root Mean-Squared Error (RMSE) is %f\n', RMSE);
fprintf('\n The Peak Signal-to-Noise Ratio (PSNR) is %f dB\n', PSNR);

% Plot MSE, RMSE, and PSNR in a single bar chart
subplot(2, 2, 4); % 2 rows, 2 columns, position 4
bar([MSE, RMSE, PSNR]);
set(gca, 'XTickLabel', {'MSE', 'RMSE', 'PSNR'}, 'XTick', 1:3);
ylabel('Error Values');
title('Error Metrics');

% Adjust layout to prevent label overlap
set(gcf, 'Position', get(0, 'Screensize')); % Maximize figure to fullscreen for readability
