% Define the file path for the input image
input_image_path = 'image_gs.png';

% Call the function to convert the image to grayscale
original_image = convertToGrayscale(input_image_path);

% Introduce noise types and parameters
salt_pepper_noise = imnoise(original_image, 'salt & pepper', rand(1));
speckle_noise = imnoise(original_image, 'speckle', 0.2);

% Generate a random window width for blurring
window_width = round(10 * rand(1));

% Create a kernel for blurring
blur_kernel = ones(window_width) / window_width ^ 2;

% Apply blurring to the original image
blurred_image = imfilter(original_image, blur_kernel); 

% Define names for denoising and deblurring methods
method_names = {"Median", "Mean", "Laplacian", "Sharpening", "Laplacian", "Sharpening"};

% Initialize a cell array to store the best results
best_results = {};

% Perform denoising and deblurring for salt & pepper noise
median_filtered_salt_pepper = medianFilter(salt_pepper_noise, 3);
diff1 = sum(sum((original_image - median_filtered_salt_pepper).^2));
mean_filtered_salt_pepper = meanFilter(salt_pepper_noise, 3);
diff2 = sum(sum(abs(original_image - mean_filtered_salt_pepper).^2));
[sh11, sh12, sh13, sh14] = sharpening(salt_pepper_noise);
sh11 = original_image - sh11; 
sh12 = original_image - sh12; 
sh13 = original_image - sh13; 
sh14 = original_image - sh14; 
diff3 = sum(sum((original_image - sh11).^2));
diff4 = sum(sum((original_image - sh12).^2));
diff5 = sum(sum((original_image - sh13).^2));
diff6 = sum(sum((original_image - sh14).^2));
[~, idx] = min([diff1, diff2, diff3, diff4, diff5, diff6]);
methods = {median_filtered_salt_pepper, mean_filtered_salt_pepper, sh11, sh12, sh13, sh14};
best_results{1} = method_names{idx};
best_denoised_image1 = methods{idx};

% Perform denoising and deblurring for speckle noise
median_filtered_speckle = medianFilter(speckle_noise, 3);
diff1 = sum(sum((original_image - median_filtered_speckle).^2));
mean_filtered_speckle = meanFilter(speckle_noise, 3);
diff2 = sum(sum((original_image - mean_filtered_speckle).^2));
[sh21, sh22, sh23, sh24] = sharpening(speckle_noise);
sh21 = original_image - sh21; 
sh22 = original_image - sh22; 
sh23 = original_image - sh23; 
sh24 = original_image - sh24; 
diff3 = sum(sum((original_image - sh21).^2));
diff4 = sum(sum((original_image - sh22).^2));
diff5 = sum(sum((original_image - sh23).^2));
diff6 = sum(sum((original_image - sh24).^2));
[~, idx] = min([diff1, diff2, diff3, diff4, diff5, diff6]);
methods = {median_filtered_speckle, mean_filtered_speckle, sh21, sh22, sh23, sh24};
best_results{2} = method_names{idx};
best_denoised_image2 = methods{idx};

% Perform denoising and deblurring for blurred image
median_filtered_blurred = medianFilter(blurred_image, 3);
diff1 = sum(sum((original_image - median_filtered_blurred).^2));
mean_filtered_blurred = meanFilter(blurred_image, 3);
diff2 = sum(sum((original_image - mean_filtered_blurred).^2));
[sh31, sh32, sh33, sh34] = sharpening(blurred_image);
sh31 = original_image - sh31; 
sh32 = original_image - sh32; 
sh33 = original_image - sh33; 
sh34 = original_image - sh34; 
diff3 = sum(sum((original_image - sh31).^2));
diff4 = sum(sum((original_image - sh32).^2));
diff5 = sum(sum((original_image - sh33).^2));
diff6 = sum(sum((original_image - sh34).^2));
[~, idx] = min([diff1, diff2, diff3, diff4, diff5, diff6]);
methods = {median_filtered_blurred, mean_filtered_blurred, sh31, sh32, sh33, sh34};
best_results{3} = method_names{idx};
best_deblurred_image = methods{idx};

% Calculate gradients
[gradient_x, gradient_y] = gradientCalc(original_image);

% Calculate the magnitude of gradients
magnitude = gradient_x.^2 - gradient_y.^2;

% Display gradient images
figure;
imshow(gradient_x);
title('Gradient X');
saveas(gcf, 'gradientx2.jpg');

figure;
imshow(gradient_y);
title('Gradient Y');
saveas(gcf, 'gradienty2.jpg');

figure;
imshow(magnitude);
title('Magnitude');
saveas(gcf, 'magnitude.jpg');

% Create subplots for gradient images
figure;

% Plot Gradient X
subplot(1, 3, 1);
imshow(gradient_x);
title('Gradient X');

% Plot Gradient Y
subplot(1, 3, 2);
imshow(gradient_y);
title('Gradient Y');

% Plot Magnitude
subplot(1, 3, 3);
imshow(magnitude);
title('Magnitude');

% Save the combined gradient figure
saveas(gcf, 'combined_gradients.jpg');

% Create subplots for salt & pepper denoising results
figure;
subplot(1, 3, 1);
imshow(salt_pepper_noise);
title('Distorted Image (Salt & Pepper)');

subplot(1, 3, 2);
imshow(best_denoised_image1);
title(['Best Denoising: ' best_results{1}]);

subplot(1, 3, 3);
imshow(original_image - best_denoised_image1);
title('Difference (Original - Best Denoising)');

% Create subplots for speckle denoising results
figure;
subplot(1, 3, 1);
imshow(speckle_noise);
title('Distorted Image (Speckle)');

subplot(1, 3, 2);
imshow(best_denoised_image2);
title(['Best Denoising: ' best_results{2}]);

subplot(1, 3, 3);
imshow(original_image - best_denoised_image2);
title('Difference (Original - Best Denoising)');

% Create subplots for deblurring results
figure;
subplot(1, 3, 1);
imshow(blurred_image);
title('Blurred Image');

subplot(1, 3, 2);
imshow(best_deblurred_image);
title(['Best Deblurring: ' best_results{3}]);

subplot(1, 3, 3);
