function [ son ] = crossover( father,mother )
%Efetua o crossover entre dois pais gerando um descendente, faz isso com order operator
%Recebe como parâmetro:
%father - "Pai"
%mother - "Mãe"

    son = zeros(size(father));
    
    %Divide o array dos pais em 3, assim gerando três subsequências
    sizeDescendant = ceil(size(father,2) / 3);
    
    %Filho recebe segmento central do pai
    son(sizeDescendant + 1:sizeDescendant + sizeDescendant) = father(sizeDescendant + 1:sizeDescendant + sizeDescendant);
    initial = sizeDescendant + sizeDescendant + 1;
    sonIdx = sizeDescendant + sizeDescendant + 1;
    
    %Percorre mãe, a partir o último segmento, e preenche os espaços em
    %branco do filho.
    while 1
        %Se o item atual da mãe não existem em lugar nenhum no filho
        %adiciona ele
        if ~any(mother(initial)==son)
            son(sonIdx) = mother(initial);
            sonIdx = sonIdx + 1;
            if sonIdx > size(son,2)
                sonIdx = 1;
            end
        end
        initial = initial + 1;
        %Se o indice da mãe é maior que o tamanho dela reseta ele para um
        %(isso proporciona a funcionalidade de reiniciar a lista)
        if initial > size(mother,2)
            initial = 1;
        end
        %Se o indice do filho chegou no começo do pedaço central, então ele
        %está todo preenchido e pode para a repetição
        if sonIdx == sizeDescendant + 1
            break
        end
    end
end

