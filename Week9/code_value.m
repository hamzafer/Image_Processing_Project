function [ code ] = code_value( value )

%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% EXPLANATIONS:
% To this function, we pass a value (value) and encode it. First, it
% converts the value to binary and then, if the value being encoded is negative
% (less than zero), we invert the bits (that is, 1s become 0s and vice
% versa).
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

    code = dec2bin(abs(value));   
    
    if(value<0)
        for i=1:length(code)
            if(code(i)=='1')
                code(i)='0';
            else
                code(i)='1';
            end
        end
    end
    
end

