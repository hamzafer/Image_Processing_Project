function [eqImg, normHist2] = histogramEq(A, img, n)
    value = 2^n - 1; % calculate max intensity
    A = double(A); 
    max_val = max(img(:)); % finding the maximum pixel value
    probs = A ./ sum(A); % probability of each pixel value
    cumP = cumsum(probs); % cumulative sum of the probabilities.
    normHist = double(cumP) * double(value); % calculating the new histogram
    normHist2 = floor(normHist); 
    eqImg = img;
    for i = 1:max_val+1 % aaplying histogram equalization
        eqImg(img == i-1) = normHist2(i);
    end
end
