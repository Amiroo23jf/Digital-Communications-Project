 function [y] = EncodeBCH11(x)
%ENCODEBCH11 encode using BCH(15,11)
x_arr = x == '1';
y = num2str(encode(x_arr, 15, 11, 'cyclic/binary', [1, 0, 0, 1, 1]));
y = y(~isspace(y));
end

