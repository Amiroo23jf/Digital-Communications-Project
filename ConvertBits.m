function [y] = ConvertBits(x)
%CONVERTBITS Convert a bit sequence to an audio channel output
n=7;

x_len = length(x);

y = zeros(1, x_len/n);

for i=1:x_len/n
   y(i) = bin2dec(x(n*(i-1) + 1:n*i));
   if y(i) > 2^(n-1) - 1
       y(i) = y(i) - 2^n;
   end
end
y = y/2^n;

end

