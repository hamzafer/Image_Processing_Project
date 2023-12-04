function probability = calculate_probability(histogram)
    total_count = sum(histogram);
    % performing loop element-wise division
    probability = histogram / total_count;
end
