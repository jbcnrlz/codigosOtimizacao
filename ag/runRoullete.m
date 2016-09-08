function [ index ] = runRoullete( fitVal, idx )
%Efetua Seleção utilizando o método da roleta
%Recebe como parâmetro:
%fitVal - Valores de Fitness para as soluções
%idx - Lista ordenada das melhores soluções

    index = 0;
    while index == 0
        %Define um valor de passo para gerar os "slots" da roleta
        stepSize = 1/(length(fitVal));
        %Gera uma lista distribuindo igualmente as posições entre todos os
        %itens da solução
        evenDist = 0:stepSize:1;        
        newEvenDist = zeros(size(evenDist));
        %Ajusta os valores de Fitness, colocando o menor para o maior valor
        %(entre 0 e 1)
        fitPerc = 1 - (fitVal / sum(fitVal));
        %Usa os valores de Fitness ajustados para aumentar ou diminuir cada
        %"slot" da roleta - assim os menores tem um pedaço maior.
        for i = 2:length(evenDist)
            newEvenDist(i) = evenDist(i) + (fitPerc(i-1) + (evenDist(i - 1) + evenDist(i)));
        end

        %Sorteia uma posição
        sortPosition = 0.000002 + (newEvenDist(end))*rand;

        %Encontra onde, na roleta, se encaixa a nova posição
        for i = 2:length(newEvenDist)
            if newEvenDist(i-1) < sortPosition && sortPosition <= newEvenDist(i)
                index = idx(i-1);
            end        
        end    
    end
end

