function [normalizedImage] = normalizeImage(inputImage)
    % Find the maximum and minimum values in the input image
    maxVal = max(inputImage(:));
    minVal = min(inputImage(:));
    
    % Normalize the input image and convert it to uint8 format
    normalizedImage = uint8(floor(double(double(inputImage - minVal) / double(maxVal - minVal)) * 255));
end
