function [y] = QPSKModulation(x, Eb)
%QPSKMODULATION Summary of this function goes here
%   Detailed explanation goes here
if mod(length(x), 2) == 1
    x = append(x,  '0');
end
x_len = length(x);

y = zeros(1, x_len/2);
for i=1:x_len/2
    x2 = x(2*i-1:2*i);
    if isequal(x2, '00')
        y(i) = sqrt(Eb) * (1 + 1j);
    elseif isequal(x2, '01')
        y(i) = sqrt(Eb) * (-1 + 1j);
    elseif isequal(x2, '11')
        y(i) = sqrt(Eb) * (-1 - 1j);
    else  
        y(i) = sqrt(Eb) * (1 - 1j);
    end
end
end

