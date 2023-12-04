function equalized_matrix = replace_values(matrix, floored_hist)
    % Initialize the equalized matrix with the original matrix
    equalized_matrix = matrix;

    [rows, cols] = size(matrix);

    % Iterate through each element in the matrix
    for i = 1:rows
        for j = 1:cols
            value = matrix(i, j);
            equalized_matrix(i,j) = floored_hist(value+1);
        end
    end
end
