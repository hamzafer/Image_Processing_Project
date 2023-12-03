function grayImage = convertToGrayscale(imagePath)
    % convertToGrayscale - Converts an image to grayscale.
    %
    % Syntax: grayImage = convertToGrayscale(imagePath)
    %
    % Inputs:
    %    imagePath - String. Path to the image file.
    %
    % Outputs:
    %    grayImage - Matrix. Grayscale image.

    % Read the image from the given path
    originalImage = imread(imagePath);

    % Check if the image is in color (3 channels)
    if size(originalImage, 3) == 3
        % Convert to grayscale
        grayImage = rgb2gray(originalImage);
    else
        % The image is already grayscale
        grayImage = originalImage;
    end
end
