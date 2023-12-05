function [matchedImage] = histogramMatching(image1, image2, options)
    if options == true
        [~, probabilities1] = performHistogramEqualization(calculateHistogram(image1), image1, 8);
        [~, probabilities2] = performHistogramEqualization(calculateHistogram(image2), image2, 8);
    else
        [~, probabilities1] = performHistogramEqualization(calculateHistogram(image1), image1, 8);
        probabilities2 = image2;
    end
    
    % Create a mapping for each intensity level
    mapping = zeros(256, 1, 'uint8');
    
    for i = 1:256 % Intensity levels of the source image
        minDiff = inf;
        closestIndex = 1;
        
        for j = 1:256 % Intensity levels of the reference image
            difference = abs(probabilities1(i) - probabilities2(j));
            
            if difference < minDiff
                minDiff = difference;
                closestIndex = j; % Finding the closest corresponding intensity level
            end
        end
        
        mapping(i) = closestIndex - 1;
    end

    % Apply the mapping to image1
    matchedImage = mapping(double(image1) + 1);
end
