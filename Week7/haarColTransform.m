function transformedCols = haarColTransform(imageCols, scalingFactor)
    % haarColTransform - Apply the Haar wavelet transform to each column.
    %
    % Syntax: transformedCols = haarColTransform(imageCols)
    %
    % Inputs:
    %    imageCols - Matrix of image columns.
    %
    % Outputs:
    %    transformedCols - Matrix of transformed columns.

    numCols = length(imageCols);
    for colIndex = 1:numCols
        rowIndex = 1;
        for elementIndex = 1:2:(numCols - 1)
            % Calculate Low (L) component: Average and divide by 2
            transformedCols(rowIndex, colIndex) = (imageCols(elementIndex, colIndex) + imageCols(elementIndex + 1, colIndex)) / scalingFactor;

            % Calculate High (H) component: Subtract and divide by 2
            transformedCols(rowIndex + numCols / 2, colIndex) = (imageCols(elementIndex, colIndex) - imageCols(elementIndex + 1, colIndex)) / scalingFactor;

            rowIndex = rowIndex + 1;
        end
    end 
end
