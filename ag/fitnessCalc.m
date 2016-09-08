function [ fitnessArray ] = fitnessCalc( solutions,distances )
%Percorre um array com um path contendo uma solução e faz o somatório de
%todas as distâncias.
%Recebe como parâmetro:
%solutions - População para cálculo do fitness
%distances - Matrix de distâncias

    fitnessArray = zeros(size(solutions,1),1);
    for i = 1:size(solutions,1)
        for j = 1:size(solutions,2) - 1
            fitnessArray(i) = fitnessArray(i) + distances(solutions(i,j),solutions(i,j+1));
        end
        fitnessArray(i) = fitnessArray(i) + distances(solutions(i,end),solutions(i,1));
    end
end

