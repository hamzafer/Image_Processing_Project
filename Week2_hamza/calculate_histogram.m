% Normalize histogram:
function histogram = calculate_histogram(matrix)
    [rows, cols] = size(matrix);
    % Initialize a histogram array with zeros for values 1 to 10
    histogram = zeros(1, 10);

    % Iterate through each element in the matrix
    for i = 1:rows
        for j = 1:cols
            value = matrix(i, j);
            if value >= 1 && value <= 10 % Assuming values range from 1 to 10
                histogram(value) = histogram(value) + 1; % Increment the corresponding bin in the histogram
            end
        end
    end
end
