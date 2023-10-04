function [y] = DecodeBCH7(x)
x_arr = x=='1';
genpoly = [1, 1, 1, 0, 1, 0, 0, 0, 1]; 
parmat = cyclgen(15,genpoly);
trt = syndtable(parmat); 
y = decode(x_arr,15,7,'cyclic/binary',genpoly,trt);
y = num2str(y);
y = y(~isspace(y));
end
