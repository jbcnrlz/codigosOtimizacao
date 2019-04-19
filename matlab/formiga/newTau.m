function [ newtaus ] = newTau( fbest, fworst, zeta, oldTaus,p, idxBest )
%NEWTAU Summary of this function goes here
%   Detailed explanation goes here

    newtaus = zeros(size(oldTaus));
    bestPheromone = 0;
    for i = 1:length(fbest)
        bestPheromone = bestPheromone + ((zeta*fbest(i))/fworst(1));
    end
    for i = 1:length(newtaus)
        if any(i == idxBest)
            newtaus(i) = oldTaus(i) + bestPheromone;
        else
            newtaus(i) = (1-p)*oldTaus(i);
        end
    end

end

