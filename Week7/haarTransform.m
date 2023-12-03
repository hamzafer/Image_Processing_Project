function transformedMatrix = haarTransform(inputMatrix)
    % haarTransform - Applies the Haar wavelet transform to an input matrix.
    %
    % Syntax: transformedMatrix = haarTransform(inputMatrix)
    %
    % Inputs:
    %    inputMatrix - Matrix. The input image or signal matrix.
    %
    % Outputs:
    %    transformedMatrix - Matrix. The transformed matrix after applying Haar wavelet.

    matrixSize = length(inputMatrix);
    transformedMatrix = inputMatrix;

    % Apply the Haar transform iteratively
    % The process stops when the transformable area reaches 16x16. For an initial size of 256x256,
    % this performs the transform across log2(256/16) = log2(16) = 4 levels.
    while matrixSize > 16
        % Apply row and column Haar transforms
        transformedRows = haarRowTransform(transformedMatrix(1:matrixSize, 1:matrixSize));
        transformedCols = haarColTransform(transformedRows);

        % Update the matrix with the transformed data
        transformedMatrix(1:matrixSize, 1:matrixSize) = transformedCols;

        % Halve the matrix size for the next iteration
        matrixSize = matrixSize / 2;
    end
end
