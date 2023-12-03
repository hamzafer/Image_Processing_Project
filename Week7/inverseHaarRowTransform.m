function originalRows = inverseHaarRowTransform(transformedRows)
    % inverseHaarRowTransform - Apply the inverse Haar wavelet transform to each row.
    %
    % Syntax: originalRows = inverseHaarRowTransform(transformedRows)
    %
    % Inputs:
    %    transformedRows - Matrix of transformed rows.
    %
    % Outputs:
    %    originalRows - Matrix of original rows before Haar transform.

    numRows = length(transformedRows);
    for rowIndex = 1:numRows
        colIndex = 1;
        for elementIndex = 1:(numRows / 2)
            % Reconstruct Low (L) component
            originalRows(rowIndex, colIndex) = (transformedRows(rowIndex, elementIndex) + transformedRows(rowIndex, elementIndex + numRows / 2)) / 2;

            % Reconstruct High (H) component
            originalRows(rowIndex, colIndex + 1) = (transformedRows(rowIndex, elementIndex) - transformedRows(rowIndex, elementIndex + numRows / 2)) / 2;

            colIndex = colIndex + 2;
        end
    end
end
