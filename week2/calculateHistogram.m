function [histogramData] = calculateHistogram(inputImage)
    % Convert the input image to double
    inputImage = double(inputImage);
    
    % Initialize an array to count the occurrence of each pixel value
    histogramData = zeros(256, 1);
    
    % Get the size of the input image
    imageSize = size(inputImage);
    
    for i = 1:imageSize(1)
        for j = 1:imageSize(2)
            % Increment the count for the corresponding pixel value
            histogramData(inputImage(i, j) + 1) = histogramData(inputImage(i, j) + 1) + 1;
        end
    end
    
    % Plot the histogram
    bar(histogramData);
end
