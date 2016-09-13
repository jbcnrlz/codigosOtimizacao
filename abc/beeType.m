function [ x,v,f,melhoria] = beeType( type,x,v,f,melhoria )
%BEETYPE Summary of this function goes here
%   Detailed explanation goes here
    for i = 1:length(x)
        v(i) = generateNewV(x,length(x),i);
        valorAtual = fitness(v(i));
        if f(i) < valorAtual
            x(i) = v(i);
            f(i) = valorAtual;
            melhoria(i) = 0;
        else
            melhoria(i) = melhoria(i) + 1;
        end
    end

end

