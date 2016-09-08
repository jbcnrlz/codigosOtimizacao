function [ result ] = fitness( x )
%FITNESS Summary of this function goes here
%   Detailed explanation goes here
    result = zeros(size(x));
    for i = 1:length(x)
        result(i) = -x(i)^2+2*x(i)+11;
    end

end

