function [ valorSol, solucao ] = agCaixeiro( taxaCruzamento, taxaMutacao, populationSize, citiesData, maxPopSize, itTime, updateRealTime )
%Função que resolve problema do caixeiro viajanta utilizando algoritmo genético;
%Recebe como parâmetro:
%taxaCruzamento - % do cruzamento
%taxaMutacao - % do mutação
%populationSize - tamanho da população inicial
%citiesData - Dados das cidades
%maxPopSize - Tamanho máximo que uma população pode alcançar
%iTtime - Quantidade de vezes que as iterações serão feitas
%updateRealTime - Se deseja ter os gráficos atualizando em tempo real durante o processo de busca pelo caminho mínimo.

    iteracoesHistorico = zeros(itTime,1);
    times = itTime;

    valorSol = inf;
    sizeData = size(citiesData);
    eucDistanceCities = zeros(sizeData(1),sizeData(1));
    d = zeros(sizeData(1),sizeData(1));
    
    %Caso não seja para atualizar em tempo real, mostra a barra de
    %progresso
    if (updateRealTime == 0)
        h = waitbar(0,'Processando operações...');
    end
    
    %Calcula a matriz de distância
    for n = 1:sizeData(1)
        for j = 1:sizeData(1)
            d(n,j) = ((citiesData(n,2)-citiesData(j,2))^2+(citiesData(n,3)-citiesData(j,3))^2);
            eucDistanceCities(n,j) = sqrt(d(n,j));
        end
    end
    
    %Gera a população inicial
    solutionSpace = generateInitialPop(populationSize,sizeData(1));
    
    %Começa a iterar buscando convergência
    while itTime > 0
        iteracoesHistorico(times - (itTime - 1),1) = valorSol;
        
        %Calcula o fitness (somatório de todas as distâncias de um caminho)
        fitValues = fitnessCalc(solutionSpace,eucDistanceCities);
        [fitOrdered, solNumber] = sort(fitValues);
        
        %Se o valor do menor fitness for menor que a solução já encontrada
        %atualiza o valor da menor solução e a solução
        if valorSol > fitOrdered(1)
            valorSol = fitOrdered(1);
            solucao = solutionSpace(solNumber(1),:);
            %Se estiver marcado para atualiza em tempo real constrói o
            %gráfico na tela (atualiza a lista de solucoes)
            if (updateRealTime == 1)
                generateGraphRepr(valorSol,solucao,citiesData,times - (itTime - 1),iteracoesHistorico,eucDistanceCities);
            end
        else
            %Se estiver marcado para atualiza em tempo real constrói o
            %gráfico na tela (não atualiza a lista de solucoes)
            if (updateRealTime == 1)
                generateGraphRepr(valorSol,solucao,citiesData,times - (itTime - 1),iteracoesHistorico,eucDistanceCities);
            end
        end
        
        %Atualiza a progressbar
        if (updateRealTime == 0)
            waitbar((times - (itTime - 1)) / times);
        end
        
        %Seleciona usando o método da roleta
        [selecteds, ~]= selectionFit(fitValues,solutionSpace,taxaCruzamento);
        %Gera nova população
        solutionSpace = generateNewPop(selecteds,taxaMutacao,maxPopSize,solutionSpace,solNumber);
        itTime = itTime - 1;
    end
    if (updateRealTime == 0)
        close(h);
    end
    %Mostra os resultados finais do processo
    generateGraphRepr(valorSol,solucao,citiesData,times - (itTime - 1),iteracoesHistorico,eucDistanceCities);

end