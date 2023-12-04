function B = create_3bit_image(A)
    % Define the function f(l)
    f = @(l) 1 + abs(l - 5);

    % Initialize the 3-bit image B
    B = zeros(size(A));

    % Apply the function f to create B
    for i = 1:size(A, 1)
        for j = 1:size(A, 2)
            B(i, j) = f(A(i, j));
        end
    end
end
