function originalCols = inverseHaarColTransform(transformedCols)
    % inverseHaarColTransform - Apply the inverse Haar wavelet transform to each column.
    %
    % Syntax: originalCols = inverseHaarColTransform(transformedCols)
    %
    % Inputs:
    %    transformedCols - Matrix of transformed columns.
    %
    % Outputs:
    %    originalCols - Matrix of original columns before Haar transform.

    numCols = length(transformedCols);
    for colIndex = 1:numCols
        rowIndex = 1;
        for elementIndex = 1:(numCols / 2)
            % Reconstruct Low (L) component
            originalCols(rowIndex, colIndex) = (transformedCols(elementIndex, colIndex) + transformedCols(elementIndex + numCols / 2, colIndex)) / 2;

            % Reconstruct High (H) component
            originalCols(rowIndex + 1, colIndex) = (transformedCols(elementIndex, colIndex) - transformedCols(elementIndex + numCols / 2, colIndex)) / 2;

            rowIndex = rowIndex + 2;
        end
    end
end
