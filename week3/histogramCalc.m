function [result] = histogramCalc(A)
    A = double(A);
    result = zeros(256,1); % create an array for counting each pixel's occurence
    c = size(A); 
    for i=1:c(1)
        for j=1:c(2)
            result(A(i,j)+1) = result(A(i,j)+1)+1; % count the occurences
        end
    end
% bar(result); % plt the histogram
end 