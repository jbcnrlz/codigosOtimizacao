function [ solutionSpace ] = generateInitialPop( initialNumber,sizeData )
%Gera população inicial aleatória utilizando randperm
%Recebe como parâmetro:
%initialNumber - tamanho inicial da população
%sizeData - tamanho do vetor da solução
    
    solutionSpace = zeros(initialNumber,sizeData);
    for n = 1:initialNumber
        solutionSpace(n,:) = randperm(sizeData);
    end
end

