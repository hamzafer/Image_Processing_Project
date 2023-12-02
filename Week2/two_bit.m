function two_bin_hist = two_bit(matrix)
    [rows, cols] = size(matrix);
    two_bin_hist = zeros(2);
    threshold = 5;

    for i = 1:rows
        for j = 1:cols
            value = matrix(i, j);
            if(value < threshold)
                two_bin_hist(1) = two_bin_hist(1) + 1;
            else
                two_bin_hist(2) = two_bin_hist(2) + 1;
            end
        end
    end
end
