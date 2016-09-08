function [ xmen ] = mutation(son,type)
%Efetua mutação
%Recebe como parâmetro:
%son - Em quem aplicar a mutação
%type - Tipo de mutação

    %Escolhe dois indices e garante que não serão iguais
    city1 = 0;
    city2 = 0;    
    while city1 == city2
        city1 = randi([1 size(son,2)]);
        city2 = randi([1 size(son,2)]);
    end
    %Escolhe entre os tipos de mutação
    switch type
        case 1
            %Inversion
            son(1,city1:city2) = son(1,city2:-1:city1);
        case 2
            %Reciprocal Exchange
            son(1,[city1 city2]) = son(1,[city2 city1]);
    end
    xmen = son;

end

