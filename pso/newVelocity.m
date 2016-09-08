function [ newVelocity ] = newVelocity( velocities, localBestFit, globalBest, x, iter )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    for i = 1:size(velocities,2)
        velocities(iter,i) = velocities(iter - 1,i) + rand*(localBestFit(i)-x(iter - 1,i)) + rand*(globalBest-x(iter-1,i));
    end
    newVelocity = velocities(iter,:);
end

