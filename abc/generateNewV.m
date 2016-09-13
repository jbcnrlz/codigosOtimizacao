function [ newV ] = generateNewV( x,numberBees, i )
%GENERATENEWV Summary of this function goes here
%   Detailed explanation goes here
    k = randi(numberBees);
    fi = unifrnd(-1,1);
    newV = x(i)+fi*(x(i) - x(k));

end

