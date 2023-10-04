function [y] = DQPSKDemodulation(x, was_odd)
N = length(x); % length of the input
y = repmat('0', [1, 2*N - 2]);
for i=1:N-1
    theta = angle(x(i+1)*conj(x(i)));
    if theta >= -pi/4 && theta < pi/4
        y(2*i-1:2*i) = '00';
    elseif theta >= pi/4 && theta < 3*pi/4
        y(2*i-1:2*i) = '01';
    elseif theta >= -3*pi/4 && theta < -pi/4
        y(2*i-1:2*i) = '10';
    else
        y(2*i-1:2*i) = '11';
    end
end

% remove extra bit if the actual length was odd
if was_odd == 1
    y = y(1:2*N-3);
end
end

