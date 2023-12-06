function[result] = meanFilter(image, windowSize)
    % get the sizes of the image
    [rows, cols] = size(image);
    window = windowSize;

    % initialize the output image
    result = zeros(rows, cols, 'uint8');

    % calculate the half window size
    halfW = floor(window/2);
    
    % padding an image to fit the kernel  
    newIm = padarray(image, [halfW, halfW], 'symmetric');

    % perform mean filtering
    for i = 1:rows
        for j = 1:cols
            % find the corresponding box defined by window size
            box = newIm(i:i+2*halfW, j:j+2*halfW);
            result(i, j) = mean(box(:));
        end
    end
end