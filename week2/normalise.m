function [result] = normalise(A)
maxnum = max(A(:));
minnum = min(A(:));
result = uint8(floor(double(double(A-minnum)./double(maxnum-minnum)).*(255)));
end