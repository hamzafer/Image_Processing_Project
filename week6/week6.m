function[] = week6(image)
    FT = fft2(image);
    magnitude = abs(FT);
    phase = angle(FT);
    figure;
    subplot(1,2,1)
    imshow(log10(magnitude),[])
    title("DFT magnitude in log10")
    subplot(1,2,2)
    imshow(log10(phase),[])
    title("DFT phase in log10")
     
    F_shifted = fftshift(FT); % shift to center the low frequencies
    
    
    [rows, cols] = size(image);
    numPixels = rows * cols;
    
    % store metrics
    MSE = zeros(numPixels, 1);
    RMSE = zeros(numPixels, 1);
    PSNR = zeros(numPixels, 1);
    compressionRates = zeros(numPixels, 1);
    % calculating the center of a circular mask to gradually increase the
    % radius
    centerX = ceil(cols/2);
    centerY = ceil(rows/2);
    [X, Y] = meshgrid(1:cols, 1:rows);
    % inverse Fourier transform
    for k = 1:numPixels
        mask = sqrt((X - centerX).^2 + (Y - centerY).^2) <= sqrt(k); % using circular mask
        F_temp = F_shifted .* mask; % finding the region
        img_reconstructed = ifft2(ifftshift(F_temp)); % inverse FFT on one region

        % calculate quality metrics
        MSE(k) = immse(abs(img_reconstructed), double(image));
        RMSE(k) = sqrt(MSE(k));
        PSNR(k) = 10 * log10(255^2 / MSE(k));
        
        % Calculate compression rate
        compressionRates(k) = sum(mask(:)) / numPixels;
    end

    % plot the results
    figure;
    plot(compressionRates, MSE, 'b');
    title('MSE vs. Compression Rate');
    xlabel('Compression Rate');
    ylabel('MSE');

    figure;
    plot(compressionRates, RMSE, 'r');
    title('RMSE vs. Compression Rate');
    xlabel('Compression Rate');
    ylabel('RMSE');

    figure;
    plot(compressionRates, PSNR, 'g');
    title('PSNR vs. Compression Rate');
    xlabel('Compression Rate');
    ylabel('PSNR');

    figure;
    subplot(1, 2, 1), imshow(image), title('Original Image');
    subplot(1, 2, 2), imshow(abs(img_reconstructed), []), title(['Reconstructed Image at Compression Rate: ', num2str(compressionRates(k))]);
 

end