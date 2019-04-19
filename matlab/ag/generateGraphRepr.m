function [ output_args ] = generateGraphRepr( valorSol, solution, citiesData, iteration,iteracoesHistorico,distanceMatrix)
%GENERATEGRAPHREPR Summary of this function goes here
%   Detailed explanation goes here
    citiesDataArranjed = citiesData(:,2:3);
    melhorx = solution([1:size(citiesData,1) 1]);
    output_args = 0;

    subplot(2,2,1);
    plot(gca,citiesDataArranjed(:,1),citiesDataArranjed(:,2),'.');
    title(gca,'Posição das cidades');

    subplot(2,2,2);
    imagesc(distanceMatrix(solution,solution));
    title('Matrix de distância');
    
    subplot(2,2,3);
    plot(gca,citiesDataArranjed(melhorx,1),citiesDataArranjed(melhorx,2),'r.-');
    title(gca,sprintf('DT = %1.2f, IT = %d',valorSol,iteration));

    subplot(2,2,4);
    plot(iteracoesHistorico);
    title(gca,'Convergência');

    drawnow;            


end

