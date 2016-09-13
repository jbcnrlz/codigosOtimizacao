function [ luckyOne ] = runRoulette( values )
%RUNROULETTE Summary of this function goes here
%   Detailed explanation goes here
    luckyOne = 1;
    values = values / sum(values);
    runItem = rand;
    for i = 1:length(values)
        if values(i) > runItem
            luckyOne = i;
            break
        end
    end
end