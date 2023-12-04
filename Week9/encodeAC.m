function [codeAc] = encodeAC(seqCoef)

%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% EXPLANATIONS:
% This function takes a sequence of coefficients analyzed in zig-zag from
% the run length coding of the current block, and what we do is encode it with the
% following steps:
    
        % 1. Count how many zeros there are until the next coefficient

        % 2. Find the category of the coefficient
        
        % 3. Encode the category of the coefficient
        
        % 4. Encode the value (inverting bits in the case of a negative value)
        
        % 5. Concatenate the number of zeros with the encoding of the
        % category and with the encoding of the coefficient value (additional bits)
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

codeAc = char.empty;
    % 1. Count how many zeros there are until the next coefficient:
    numZeros = 0;
    

    for i=2:64
        if (sum(abs(seqCoef(i:end)))==0) % If all that remains are zeros, stop.
            codeAc = [codeAc '1010'];
            break % Exit the for loop and stop
        else
            if(numZeros == 16) % If I have 16 zeros, encode as '11111111001'
                codeAc = [codeAc '11111111001'];
                numZeros = 0;
            else
                if (seqCoef(i)~=0) % If I have a coefficient different from 0.
                    % 2. FIND THE CATEGORY OF THE COEFFICIENT:
                    catAc = find_category_AC(seqCoef(i));

                    % 3. ENCODE THE CATEGORY (SSSS):
                    cathex = dec2hex(catAc);
                    RRRR = dec2hex(numZeros);
                    runsize = [RRRR cathex];
                    
                    codeCatAc = code_category_AC(runsize);

                    % 4. ENCODE THE VALUE OF OUR coefficient:
                    codeCoefAc = code_value(seqCoef(i));

                    % 5. CONCATENATE THE TWO ENCODINGS:  
                    codeAc = [codeAc codeCatAc codeCoefAc];
                    numZeros = 0;
                else % If I have a coefficient that is 0.
                    numZeros = numZeros+1;
                end
            end
        end
    end
    
end
