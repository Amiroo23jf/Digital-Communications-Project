function [y] = Channel(x, N0, phase)
%CHANNEL Simulates a channel
y = x + sqrt(N0/2) * (randn(size(x)) + 1j * randn(size(x)));

% phase ambiguity
if isequal(phase, 1)
    k = randi([0, 7]);
    y = y * exp(1j * k * pi / 4);
end
end

