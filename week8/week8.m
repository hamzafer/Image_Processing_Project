function[result] = week8(original, scale)
    [rows, cols] = size(original);
    
    % calculate the dimensions of the resized image
    h = floor(rows / scale);
    w = floor(cols / scale);
    
    % new resized image
    result = zeros(h, w, 'uint8');
    
    % bilinear interpolation
    for i = 1:h
        for j = 1:w
            % pixel position in the original image
            x = i * scale;
            y = j * scale;
            
            % four pixel neighbors
            x1 = floor(x);
            y1 = floor(y);
            x2 = x1 + 1;
            y2 = y1 + 1;

            % check boundary conditions
          
            if x2 > rows
                x2 = rows;
            end
            if y2 > rows
                y2 = rows;
            end
          
            % calculate weights
            wa = (x2 - x) * (y2 - y);
            wb = (x - x1) * (y2 - y);
            wc = (x2 - x) * (y - y1);
            wd = (x - x1) * (y - y1);
            
            % calculate the interpolated value for the new pixel
            result(i, j) = wa * original(x1, y1) + wb * original(x2, y1) + wc * original(x1, y2) + wd * original(x2, y2);
        end
    end
    
    % Resize the original image to match the dimensions of the result
    originalResized = imresize(original, [h, w]);
    
    % Calculate SSIM
    ssimValue = ssim(originalResized, result);
    fprintf('SSIM between original and resized image: %.4f\n', ssimValue);
end
