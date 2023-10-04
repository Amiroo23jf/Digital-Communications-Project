function [y] = RemoveZeros(x)
%REMOVEZEROS Removes zeros from the beginning of the file
x_max = max(x);
x_threshold = 0.05 * abs(x_max);
for i=1:length(x)
   if abs(x(i)) >= x_threshold
       i_min = i;
       break
   end
end

for i=length(x):-1:1
    if abs(x(i)) >= x_threshold
        i_max = i;
        break
    end
end

y = x(i_min:i_max);
end
