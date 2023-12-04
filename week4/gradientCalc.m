function[Gx, Gy] = gradientCalc(image)
    % get the sizes of the image
    [rows, cols] = size(image);
    x = [-1 0 1; -2 0 2; -1 0 1];
    y = [-1 -2 -1; 0 0 0; 1 2 1];
    % initialize the output image
    Gx = zeros(rows, cols, 'uint8');
    Gy = zeros(rows, cols, 'uint8');

    % padding an image to fit the kernel  
    newIm = padarray(image, [1,1], 'symmetric');

    % perform median filtering
    for i = 1:rows
        for j = 1:cols
            % find the corresponding box defined by window size
            box = newIm(i:i+2, j:j+2);
            Gx(i, j) = sum(sum(double(box).*x));
            Gy(i, j) = sum(sum(double(box).*y));
        end
    end
end