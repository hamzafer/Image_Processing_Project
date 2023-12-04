function encodedMatrix = encodeCoefficients(zigzagSequence)
    encodedList = {};  % Initialize the list to store encoded values
    consecutiveZeros = 0;  % Counter for consecutive zeros

    % Iterate over all coefficients
    for i = 1:length(zigzagSequence)
        coefficient = zigzagSequence(i);

        if coefficient == 0
            consecutiveZeros = consecutiveZeros + 1;
        else
            % Calculate the number of bits needed to represent the coefficient
            numBits = floor(log2(abs(coefficient))) + 1;

            % Append the encoded coefficient to the list
            encodedList{end+1} = [consecutiveZeros, numBits, coefficient];

            % Reset consecutive zeros counter
            consecutiveZeros = 0;
        end
    end

    % Append [0, 0, 0] to mark the end of the block
    encodedList{end+1} = [0, 0, 0];

    % Convert the list to a matrix
    encodedMatrix = cell2mat(encodedList');
end
