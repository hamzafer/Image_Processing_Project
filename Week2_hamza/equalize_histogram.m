function normalized_hist = equalize_histogram(histogram, max_value, original)
    cumulative_prob = cumulative_probability(histogram);
    scaled_hist = scale_histogram(cumulative_prob, max_value);
    floored_hist = floor_histogram(scaled_hist);
    equalized_matrix = replace_values(original, floored_hist);
    normalized_hist = equalized_matrix;
end
