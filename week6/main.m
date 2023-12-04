% Define the file path for the input image
input_image_path = 'image_gs.png';

% Call the function to convert the image to grayscale
gray_image = convertToGrayscale(input_image_path);

% Compute the 2D Fourier Transform of the grayscale image
fourier_transform = fft2(gray_image);
magnitude_spectrum = abs(fourier_transform); % Magnitude of the Fourier Transform
phase_spectrum = angle(fourier_transform);    % Phase of the Fourier Transform

% Plot the magnitude and phase spectra in a subplot with 2 columns
figure;
subplot(1, 2, 1)
imshow(log10(magnitude_spectrum), []) % Display the magnitude spectrum in log scale
title("Magnitude Spectrum (log scale)")

subplot(1, 2, 2)
imshow(log10(phase_spectrum), []) % Display the phase spectrum in log scale
title("Phase Spectrum (log scale)")

% Shift the Fourier Transform to center the low frequencies
shifted_ft = fftshift(fourier_transform);

% Get the dimensions of the input image
[rows, cols] = size(gray_image);
num_pixels = rows * cols;

% Initialize arrays to store quality metrics and compression rates
mean_squared_error = zeros(num_pixels, 1);
root_mean_squared_error = zeros(num_pixels, 1);
peak_signal_to_noise_ratio = zeros(num_pixels, 1);
compression_rates = zeros(num_pixels, 1);

% Calculate the center of a circular mask to gradually increase the radius
center_x = ceil(cols / 2);
center_y = ceil(rows / 2);
[X, Y] = meshgrid(1:cols, 1:rows);

% Inverse Fourier transform and quality metric calculation
for k = 1:num_pixels
    mask = sqrt((X - center_x).^2 + (Y - center_y).^2) <= sqrt(k); % Circular mask
    ft_temp = shifted_ft .* mask; % Extract the region of interest
    img_reconstructed = ifft2(ifftshift(ft_temp)); % Inverse FFT on the region

    % Calculate quality metrics
    mean_squared_error(k) = immse(abs(img_reconstructed), double(gray_image));
    root_mean_squared_error(k) = sqrt(mean_squared_error(k));
    peak_signal_to_noise_ratio(k) = 10 * log10(255^2 / mean_squared_error(k));
    
    % Calculate compression rate
    compression_rates(k) = sum(mask(:)) / num_pixels;
end

% Plot the results
figure;

% Plot the three error metrics in a subplot with 3 columns
subplot(1, 3, 1)
plot(compression_rates, mean_squared_error, 'b');
title('Mean Squared Error (MSE) vs. Compression Rate');
xlabel('Compression Rate');
ylabel('MSE');

subplot(1, 3, 2)
plot(compression_rates, root_mean_squared_error, 'r');
title('Root Mean Squared Error (RMSE) vs. Compression Rate');
xlabel('Compression Rate');
ylabel('RMSE');

subplot(1, 3, 3)
plot(compression_rates, peak_signal_to_noise_ratio, 'g');
title('Peak Signal-to-Noise Ratio (PSNR) vs. Compression Rate');
xlabel('Compression Rate');
ylabel('PSNR');

% Display the original image, reconstructed image, and magnitude spectrum
subplot(1, 3, 1)
imshow(gray_image)
title('Original Image');

subplot(1, 3, 2)
imshow(abs(img_reconstructed), [])
title(['Reconstructed Image at Compression Rate: ', num2str(compression_rates(k))]);

subplot(1, 3, 3)
imshow(log10(magnitude_spectrum), [])
title("Magnitude Spectrum (log scale)")
