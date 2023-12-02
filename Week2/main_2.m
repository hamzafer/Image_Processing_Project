% Quiz 2
max_lum_value = 9;

A = generate_matrix();

% 1. Assuming f(l) = 1+|l - 5| 
% create the 3-bit image B using the following equation: 
% B(i,j) = f(A(i, j))
B = create_3bit_image(A);

% 2. Calculate the normalized image C for image B
histogram = calculate_histogram(B);
C = normalize_histogram(histogram);

% 3. Calculate the new image D if we want to apply histogram equalization for image B 
% and stretch its grey level to a 4-bit image
D = equalize_histogram(C, max_lum_value, B);

show_histogram(D);
