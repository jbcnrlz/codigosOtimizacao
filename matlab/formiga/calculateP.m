function [ outProb ] = calculateP( j,taus )
%CALCULATEP Summary of this function goes here
%   Detailed explanation goes here

    outProb = taus(j) / sum(taus);

end

