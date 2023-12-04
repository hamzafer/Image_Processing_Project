% Quiz 1
matrix = generate_matrix();

% 1. Calculate a 10-bin image histogram with bin 1 representing 0, bin 2 representing 1, etc.
histogram = calculate_histogram(matrix);

% 2. Normalize the image histogram you calculated in point 1.
normalized_histogram = normalize_histogram(histogram);

% 3. Calculate the negative image for image A
negative_image = image_negative(matrix, max(matrix(:)));

% 4. Calculate the 2-bin image histogram for Aves
two_bin_hist = two_bit(negative_image);

show_histogram(two_bin_hist);
