function [eqImg] = histogramEq(A, img, n)
    value = 2^n - 1;
    A = double(A);
    max_val = max(img(:));
    probs = A / sum(A);
    cumP = cumsum(probs);
    normHist = double(cumP) * double(value);
    normHist2 = floor(normHist);
    eqImg = img;

    for i = 1:max_val+1
        eqImg(img == i-1) = normHist2(i);
    end
end
