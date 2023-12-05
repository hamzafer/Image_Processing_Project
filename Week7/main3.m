% DCT AND WHT looping

% Path to the image file
imagePath = 'image_gs.png';

% Call the convertToGrayscale function
image = convertToGrayscale(imagePath);

[rows, cols] = size(image);
numPixels = min(rows, cols);

% apply WHT to columns
wht_c = fwht(im2double(image));
% apply WHT to rows    
wht_r = fwht(wht_c');
% resultant WHT
wht = wht_r';

% apply DCT
dct = dct2(im2double(image));

% store metrics
whtMSE = zeros(numPixels, 1);
whtRMSE = zeros(numPixels, 1);
whtPSNR = zeros(numPixels, 1);

dctMSE = zeros(numPixels, 1);
dctRMSE = zeros(numPixels, 1);
dctPSNR = zeros(numPixels, 1);

compressionRates = zeros(numPixels, 1);

for k = 1:min(rows, cols)
    mask = zeros(rows, cols);
    mask(1:k, 1:k) = 1;
    
    wht_p = wht .* mask;
    wht_inv = ifwht(wht_p');
    wht_cinv = ifwht(wht_inv');
    rWHT = wht_cinv;
    
    dct_p = dct .* mask;
    rDCT = idct2(dct_p);

    rDCT = uint8(rDCT * 255);
    rWHT = uint8(rWHT * 255);
    
    compressionRates(k) = sum(mask(:)) / numPixels;
    [whtMSE(k), whtRMSE(k), whtPSNR(k)] = metrics(image, rWHT);
    [dctMSE(k), dctRMSE(k), dctPSNR(k)] = metrics(image, rDCT);
end

% Plot WHT and DCT results in two subplots with 3 columns each
figure;

% Subplot for WHT
subplot(1, 3, 1)
plot(compressionRates, whtMSE, 'b');
disp(whtMSE);
title('WHT: MSE vs. Compression Rate');
xlabel('Compression Rate');
ylabel('MSE');

subplot(1, 3, 2)
plot(compressionRates, whtRMSE, 'r');
title('WHT: RMSE vs. Compression Rate');
xlabel('Compression Rate');
ylabel('RMSE');

subplot(1, 3, 3)
plot(compressionRates, whtPSNR, 'g');
title('WHT: PSNR vs. Compression Rate');
xlabel('Compression Rate');
ylabel('PSNR');

% Subplot for DCT
figure;

subplot(1, 3, 1)
plot(compressionRates, dctMSE, 'b');
disp(dctMSE);
title('DCT: MSE vs. Compression Rate');
xlabel('Compression Rate');
ylabel('MSE');

subplot(1, 3, 2)
plot(compressionRates, dctRMSE, 'r');
title('DCT: RMSE vs. Compression Rate');
xlabel('Compression Rate');
ylabel('RMSE');

subplot(1, 3, 3)
plot(compressionRates, dctPSNR, 'g');
title('DCT: PSNR vs. Compression Rate');
xlabel('Compression Rate');
ylabel('PSNR');
