function reconstructedMatrix = inverseHaarTransform(transformedMatrix, scalingFactor)
    % inverseHaarTransform - Applies the inverse Haar wavelet transform to a matrix.
    %
    % Syntax: reconstructedMatrix = inverseHaarTransform(transformedMatrix)
    %
    % Inputs:
    %    transformedMatrix - Matrix. The matrix after applying the Haar wavelet transform.
    %
    % Outputs:
    %    reconstructedMatrix - Matrix. The reconstructed matrix, approximating the original.

    totalSize = length(transformedMatrix);
    currentSize = 32;

    reconstructedMatrix = transformedMatrix;
    
    % Apply the inverse Haar transform iteratively
    while currentSize <= totalSize
        % Apply inverse column and row Haar transforms
        inverseTransformedCols = inverseHaarColTransform(reconstructedMatrix(1:currentSize, 1:currentSize), scalingFactor);
        inverseTransformedRows = inverseHaarRowTransform(inverseTransformedCols, scalingFactor);

        % Update the matrix with the inversely transformed data
        reconstructedMatrix(1:currentSize, 1:currentSize) = inverseTransformedRows;

        % Double the matrix size for the next iteration
        currentSize = currentSize * 2;
    end
end
