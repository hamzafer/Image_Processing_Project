function [codeDc] = codifDC(dif)

%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% EXPLANATIONS:
% This function receives the value 'dif' (i.e., the difference between the DC
% of the current block and the DC of the previous block) and what we do is encode it
% with the following steps:

        % 1. Find the category of our 'dif' value
        
        % 2. Encode the category of our 'dif' value
        
        % 3. Encode the 'dif' value (inverting bits in case of a negative value)
        
        % 4. Concatenate the encoding of the category with the encoding
        % of our 'dif' value.   
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

    % 1. FIND THE CATEGORY OF THE VALUE dif:
    catDif = find_category_DC(dif); 
    
    % 2. ENCODE THE CATEGORY OF OUR VALUE dif:
    codeCatDif = code_category_DC(catDif);
    
    % 3. ENCODE THE VALUE OF OUR dif:
    codeDif = code_value(dif);
    
    if (dif ~= 0)
        % 4. CONCATENATE THE TWO ENCODINGS:  
        codeDc = [codeCatDif codeDif];
    else
        codeDc = [codeCatDif];
    end

end
