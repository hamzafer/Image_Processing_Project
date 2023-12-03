% Path to the image file
imagePath = 'image_gs.png';

% Call the convertToGrayscale function
grayImage = convertToGrayscale(imagePath);
doubleGrayImage = im2double(grayImage);

% Initialize a new figure for displaying images and their transforms
figure;

% Display the original grayscale image
subplot(3, 4, 1);
imshow(grayImage);
title('Original Image');

%------------------------DCT----------------------
dctImage = dct2(grayImage);
subplot(3, 4, 2);
imshow(log(abs(dctImage)),[]);
title('DCT of the image');

% Display selected low frequency DCT
% Assuming you're keeping the top-left corner of the DCT coefficients
selectedDCT = dctImage;
selectedDCT(33:end, 33:end) = 0; % Zero out all but top-left 32x32 coefficients
subplot(3, 4, 3);
imshow(log(abs(selectedDCT)), []);
title('Selected Low Frequency DCT');

% Reconstruct image from selected low frequency DCT
reconstructedDCT = idct2(selectedDCT);
subplot(3, 4, 4);
imshow(reconstructedDCT, []);
title('Reconstructed Image from DCT');

%------------------------WHT----------------------
whtImage = fwht(doubleGrayImage);
subplot(3, 4, 5);
imshow(log(abs(whtImage)), []);
title('WHT of the image');

% Display selected low frequency WHT
% Assuming you're keeping the top-left corner of the WHT coefficients
selectedWHT = whtImage;
selectedWHT(33:end, 33:end) = 0; % Zero out all but top-left 32x32 coefficients
subplot(3, 4, 6);
imshow(log(abs(selectedWHT)), []);
title('Selected Low Frequency WHT');

% Reconstruct image from selected low frequency WHT
reconstructedWHT = ifwht(selectedWHT);
subplot(3, 4, 7);
imshow(reconstructedWHT, []);
title('Reconstructed Image from WHT');

%------------------------Error Calculations----------------------
% DCT Errors
dctMSE = immse(doubleGrayImage, reconstructedDCT);
dctRMSE = sqrt(dctMSE);
dctPSNR = 10 * log10(256 * 256 / dctMSE);

% WHT Errors
whtMSE = immse(doubleGrayImage, reconstructedWHT);
whtRMSE = sqrt(whtMSE);
whtPSNR = 10 * log10(256 * 256 / whtMSE);

% Plot DCT Errors
subplot(3, 4, 8);
bar([dctMSE, dctRMSE, dctPSNR]);
set(gca, 'XTickLabel', {'MSE', 'RMSE', 'PSNR'});
title('DCT Errors');

% Plot WHT Errors
subplot(3, 4, 9);
bar([whtMSE, whtRMSE, whtPSNR]);
set(gca, 'XTickLabel', {'MSE', 'RMSE', 'PSNR'});
title('WHT Errors');

% Adjust layout to prevent label overlap
set(gcf, 'Position', get(0, 'Screensize')); % Maximize figure to fullscreen for readability
