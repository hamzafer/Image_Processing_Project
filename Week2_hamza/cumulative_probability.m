function cumulative_prob = cumulative_probability(probability)
    n = length(probability); % Get the length of the probability vector
    cumulative_prob = zeros(size(probability)); % Initialize the cumulative probability vector

    cumulative_prob(1) = probability(1); % The first element is the same as probability(1)

    for i = 2:n
        cumulative_prob(i) = cumulative_prob(i-1) + probability(i); % Accumulate the probability
    end
end
