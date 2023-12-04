function transformedRows = haarRowTransform(imageRows, scalingFactor)
    % haarRowTransform - Apply the Haar wavelet transform to each row.
    %
    % Syntax: transformedRows = haarRowTransform(imageRows)
    %
    % Inputs:
    %    imageRows - Matrix of image rows.
    %
    % Outputs:
    %    transformedRows - Matrix of transformed rows.

    numRows = length(imageRows);
    for rowIndex = 1:numRows
        colIndex = 1;
        for elementIndex = 1:2:(numRows - 1)
            % Calculate Low (L) component: Average and divide by 2
            transformedRows(rowIndex, colIndex) = (imageRows(rowIndex, elementIndex) + imageRows(rowIndex, elementIndex + 1)) / scalingFactor;

            % Calculate High (H) component: Subtract and divide by 2
            transformedRows(rowIndex, colIndex + numRows / 2) = (imageRows(rowIndex, elementIndex) - imageRows(rowIndex, elementIndex + 1)) / scalingFactor;

            colIndex = colIndex + 1;
        end
    end 
end
