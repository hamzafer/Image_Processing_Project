% Load and resize the original image
resizedImage = imresize(imread('week1_original.png'), [1024, 1024]);
original = rgb2gray(resizedImage);

% Set the scale factor for resizing
scale = 4;

% Get the dimensions of the original image
[rows, cols] = size(original);

% Calculate the dimensions of the resized image
h = floor(rows / scale);
w = floor(cols / scale);

% Create an empty matrix for the resized result
result = zeros(h, w, 'uint8');

% Perform bilinear interpolation
for i = 1:h
    for j = 1:w
        % Calculate the pixel position in the original image
        x = i * scale;
        y = j * scale;
        
        % Calculate the positions of the four pixel neighbors
        x1 = floor(x);
        y1 = floor(y);
        x2 = x1 + 1;
        y2 = y1 + 1;

        % Check boundary conditions to prevent out-of-bounds access
        if x2 > rows
            x2 = rows;
        end
        if y2 > cols
            y2 = cols;
        end
      
        % Calculate weights for interpolation
        wa = (x2 - x) * (y2 - y);
        wb = (x - x1) * (y2 - y);
        wc = (x2 - x) * (y - y1);
        wd = (x - x1) * (y - y1);
        
        % Calculate the interpolated value for the new pixel
        result(i, j) = wa * original(x1, y1) + wb * original(x2, y1) + wc * original(x1, y2) + wd * original(x2, y2);
    end
end

% Resize the original image to match the dimensions of the result
originalResized = imresize(original, [h, w]);

% Calculate Structural Similarity Index (SSIM) between original and resized image
ssimValue = ssim(originalResized, result);
fprintf('SSIM between original and resized image: %.4f\n', ssimValue);

% Display the resized result
imshow(result)
title('Resized image using bilinear interpolation');
