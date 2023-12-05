function [segmentedImage] = performImageSegmentation(inputImage)
    % Create a copy of the input image to store the segmented result
    segmentedImage = inputImage;
    
    % Define cutoff points for segmentation: 1-80, 81-110, 111-255
    lowerCutoff = 80;
    middleCutoff = 110;
    
    % Segment the image into 3 parts based on the cutoff points
    segmentedImage(inputImage < lowerCutoff) = 0;
    segmentedImage(inputImage >= lowerCutoff & inputImage < middleCutoff) = 128;
    segmentedImage(inputImage >= middleCutoff) = 255;
    
    % Save the segmented image
    % imwrite(segmentedImage, "segmented.png");
end
