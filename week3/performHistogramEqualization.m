function [equalizedImage, normalizedHistogram] = performHistogramEqualization(histogramData, inputImage, n)
    % Calculate the maximum possible pixel value
    maxPixelValue = 2^n - 1;
    
    % Convert the histogram data to double
    histogramData = double(histogramData);
    
    % Find the maximum pixel value in the input image
    maxPixelValInputImage = max(inputImage(:));
    
    % Calculate the probabilities of each pixel intensity
    probabilities = histogramData / sum(histogramData);
    
    % Calculate the cumulative probabilities
    cumulativeProbabilities = cumsum(probabilities);
    
    % Normalize the histogram
    normalizedHistogram = double(cumulativeProbabilities) * double(maxPixelValue);
    
    % Round down the values in the normalized histogram
    normalizedHistogram = floor(normalizedHistogram);
    
    % Initialize the equalized image with the input image
    equalizedImage = inputImage;

    for i = 1:maxPixelValInputImage + 1
        equalizedImage(inputImage == i - 1) = normalizedHistogram(i);
    end
end
