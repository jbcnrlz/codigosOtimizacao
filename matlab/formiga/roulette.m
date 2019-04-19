function [ selected ] = roulette( probs,sort )
%ROULETTE Summary of this function goes here
%   Detailed explanation goes here

    slices = cumsum(probs);

    for i = 1:length(slices)
        if (i == 1)
            if sort < slices(i)
                selected = i;
                break;
            end
        else
            if slices(i-1) <= sort && slices(i) > sort
                selected = i;
                break;
            end
        end
    end

end

