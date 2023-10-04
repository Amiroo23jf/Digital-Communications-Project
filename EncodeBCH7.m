function [y] = EncodeBCH7(x)
%ENCODEBCH11 encode using BCH(15,7)
x_arr = x == '1';
y = num2str(encode(x_arr, 15, 7, 'cyclic/binary', [1, 1, 1, 0, 1, 0, 0, 0, 1]));
y = y(~isspace(y));
end