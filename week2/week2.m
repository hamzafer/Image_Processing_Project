function [result] = week2(image)
    if size(image, 3) == 3 % Check if the image is grayscale
        % Convert to grayscale
        image = rgb2gray(image);
    end
    hist = histogramCalc(image);
    normalized = normalise(image);
    eqImg = histogramEq(hist, normalized, 8);

    % Calculate difference images
    diffNormalized = imabsdiff(image, normalized);
    diffEqImg = imabsdiff(image, eqImg);

    % First figure for normalized image and its difference
    figure;

    subplot(1, 3, 1);
    imshow(image);
    title('Original Image');

    subplot(1, 3, 2);
    imshow(normalized);
    title('Normalized Image');

    subplot(1, 3, 3);
    imshow(diffNormalized);
    title('Difference from Original (Normalized)');

    % Second figure for equalized image and its difference
    figure;

    subplot(1, 3, 1);
    imshow(image);
    title('Original Image');

    subplot(1, 3, 2);
    imshow(eqImg);
    title('Histogram Equalized Image');

    subplot(1, 3, 3);
    imshow(diffEqImg);
    title('Difference from Original (Equalized)');
end
