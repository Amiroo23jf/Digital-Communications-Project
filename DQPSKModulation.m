function [y] = DQPSKModulation(x, Eb)
%QPSKMODULATION Summary of this function goes here
%   Detailed explanation goes here
if mod(length(x), 2) == 1
    x = append(x,  '0');
end
x_len = length(x);

y = zeros(1, x_len/2);
y(1) = sqrt(Eb) * (1 + 1j);
for i=1:x_len/2
    x2 = x(2*i-1:2*i);
    if isequal(x2, '00')
        y(i+1) = y(i);
    elseif isequal(x2, '01')
        y(i+1) = y(i) * exp(1j * pi/2);
    elseif isequal(x2, '11')
        y(i+1) = y(i) * exp(1j * pi);
    else  
        y(i+1) = y(i) * exp(1j * 3 * pi/2);
    end
end
end

