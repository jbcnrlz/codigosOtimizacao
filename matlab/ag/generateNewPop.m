function [ solutionSpace ] = generateNewPop( selectedPeople,taxaMutacao,maximumSize,solutions,bestIdx )
%Gera nova população com base nos selecionados na roleta
%Recebe como parâmetro:
%selectedPeople - Selecionados com o método de roleta
%taxaMutacao - % de mutações que serão feitas
%maximumSize - tamanho maximo da população
%solutions - População antiga
%bestIdx - Array com o indice dos melhores resultados em ordem

    %Verifica se a nova população vai passar o máximo definido
    if (size(selectedPeople,1) * (size(selectedPeople,1) - 1)) > maximumSize
        sizeNewPop = maximumSize;
    else
        sizeNewPop = size(selectedPeople,1) * (size(selectedPeople,1) - 1);
    end
    
    solutionSpace = zeros(sizeNewPop,size(selectedPeople,2));
    %Calcula quantas mutações serão efetuadas
    numberMutation = round(size(selectedPeople,2) * taxaMutacao);
    currSolution = 1;
        
    while currSolution <= size(solutionSpace,1)        
        %Percorre as soluções selecionadas de 2 em 2
        for n = 1:2:size(selectedPeople,1)-1
            %Gera o filho usando n como pai e n+1 como mãe            
            son = crossover(selectedPeople(n,:),selectedPeople(n+1,:));
            %Gera o filho usando n+1 como pai e n como mãe
            son2 = crossover(selectedPeople(n+1,:),selectedPeople(n,:));
            %Se ainda for necessário fazer mutações randomiza um número se
            %diz se vai fazer ou não
            if numberMutation > 0 && randi([0 1]) == 1
                %Efetua mutação nos dois filhos gerados
                son = mutation(son,randi([1 2]));
                son2 = mutation(son2,randi([1 2]));
                numberMutation = numberMutation - 2;
            end
            solutionSpace(currSolution,:) = son;
            solutionSpace(currSolution+1,:) = son2;
            currSolution = currSolution + 2;
            %Se 80% das novas soluções já foram efetuadas preenche o resto
            %com as melhores soluções da população antiga
            if currSolution >= ceil(size(solutionSpace,1) * 0.7)
                break
            end
        end
        currSolution = currSolution - 1;
        %Preenche 20% da nova população com os melhores da população antiga
        for i = 1:size(bestIdx,1)
            if currSolution > size(solutionSpace,1)
                break
            end
            solutionSpace(currSolution,:) = solutions(bestIdx(i),:);
            currSolution = currSolution + 1;
        end
    end
    
end

