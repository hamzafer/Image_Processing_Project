function [ code ] = code_category_DC( category )

%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% EXPLANATIONS:
% To this function, we pass a value that is the category we want
% to encode, and we encode it using a predetermined Huffman table.
% We return a string of 'char' with the encoded value of the category.
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

    if (category==0)
        code = '00';
    end
    if (category==1)
        code = '010';
    end
    if (category==2)
        code = '011';
    end
    if (category==3)
        code = '100';
    end
    if (category==4)
        code = '101';
    end
    if (category==5)
        code = '110';
    end
    if (category==6)
        code = '1110';
    end
    if (category==7)
        code = '11110';
    end
    if (category==8)
        code = '111110';
    end
    if (category==9)
        code = '1111110';
    end
    if (category==10)
        code = '11111110';
    end
    if (category==11)
        code = '111111110';
    end

end

