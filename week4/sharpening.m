function[result1, result2, result3, result4] = sharpening(image)
    % define kernels for applying filtering
    kernel1 = [0 1 0; 1 -4 1; 0 1 0]; 
    kernel2 = [1 1 1; 1 -8 1; 1 1 1];
    kernel3 = [0 -1 0; -1 4 -1; 0 -1 0]; % laplacian filter
    kernel4 = [-1 -1 -1; -1 8 -1; -1 -1 -1];

    [rows, cols] = size(image);
    
    % creating output for each kernel 
    result1 = zeros(rows, cols, 'uint8');
    result2 = zeros(rows, cols, 'uint8');
    result3 = zeros(rows, cols, 'uint8');
    result4 = zeros(rows, cols, 'uint8');
    
    % padding an image to fit the kernel  
    newIm = padarray(image, [1, 1], 'symmetric');
    
    % perform convolution using kernels 
    for i = 1:rows
        for j = 1:cols
            % find the corresponding box defined by window size
            box = newIm(i:i+2, j:j+2);
            result1(i, j) = sum(sum(double(box).*kernel1));
            result2(i, j) = sum(sum(double(box).*kernel2));
            result3(i, j) = sum(sum(double(box).*kernel3));
            result4(i, j) = sum(sum(double(box).*kernel4));
        end
    end
end