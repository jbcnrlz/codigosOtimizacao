function [ selectedSolutions,choosedIdx ] = selectionFit( fitness,solutions,pSelected)
%Faz a seleção utilizando o método da roleta para escolher
%Recebe como parâmetro:
%fitness - Array com todos os valores de fitness para cada solução
%solutions - População atual
%pSelected - Porcentagem dos selecionados

    [fitOrdered,idxs] = sort(fitness);
    fitOrdered = (fitOrdered / length(fitOrdered));

    %Calcula quantos serão selecionados
    totalSoluctionsSelected = zeros(ceil(size(solutions,1) * pSelected),size(solutions,2));
    choosedIdx = zeros(ceil(size(solutions,1) * pSelected),1);
    i = 1;
    while i <= size(choosedIdx,1)
        %Roda a roleta e escolhe um indice
        index = runRoullete(fitOrdered,idxs);
        %Se o indice já não foi selecionados, inclui ele na lista de
        %selecionados
        if ~any(index==choosedIdx)
            totalSoluctionsSelected(i,:) = solutions(index,:);
            choosedIdx(i) = index;
            i = i + 1;
        end
    end
    
    selectedSolutions = totalSoluctionsSelected;
    
end

