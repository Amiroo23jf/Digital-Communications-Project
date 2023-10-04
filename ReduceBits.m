function [y, y_bin] = ReduceBits(x, n)
% Convert samples to n bits
y = zeros(1, length(x)); % output
y_bin = repmat('0', [1, n*length(x)]); % binary output sequence

% wav file is 16 bits
x_int = x*2^16; 
for i=1:length(x_int)
    x_bin = dec2bin(x_int(i), 16); % convert to binary
    y(i) = bin2dec(x_bin(1:n)); % choose n bits
    if y(i) > 2^(n-1)-1
        y(i) = y(i) - 2^n;
    end
    
    y_bin((i-1)*n+1:i*n) = x_bin(1:n); % add bits to binary sequence
end

y = y / 2^n;
end

