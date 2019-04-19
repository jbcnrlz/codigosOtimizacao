function [ x,v,f,melhoria] = beeType( type,x,v,f,melhoria,limite )
%BEETYPE Summary of this function goes here
%   Detailed explanation goes here
    if strcmp(type,'worker') || strcmp(type,'helper')
        for i = 1:length(x)
            if strcmp(type,'helper')
                rouletteChoosed = runRoulette(f);
                v(i) = generateNewV(x,length(x),rouletteChoosed);
            else
                v(i) = generateNewV(x,length(x),i);
            end            
            valorAtual = fitness(v(i));
            if f(i) < valorAtual
                x(i) = v(i);
                f(i) = valorAtual;
                melhoria(i) = 0;
            else
                melhoria(i) = melhoria(i) + 1;
            end
        end
    else
        for j = 1:length(x)
            if melhoria(j) > limite
                x(j) = unifrnd(-2,2);
                f(j) = fitness(x(j));
            end
        end
    end
end

