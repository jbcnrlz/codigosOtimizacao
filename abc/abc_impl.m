n_bees = 4;
iteracoes = 100;
x = [-1.5 0.0 0.5 1.25];
f = zeros(n_bees,1);
v = zeros(n_bees,1);
limite = 30;
nao_melhorou = zeros(n_bees,1);

bestForIt = zeros(iteracoes,2);

for i = 1:n_bees
    f(i) = fitness(x(1,i));
end
for i = 1:iteracoes
    for j = 1:n_bees
        v(j) = generateNewV(x,n_bees,j);
        valorAtual = fitness(v(j));
        if f(j) < valorAtual
            x(j) = v(j);
            f(j) = valorAtual;
            nao_melhorou(j) = 0;
        else
            nao_melhorou(j) = nao_melhorou(j) + 1;
        end
    end
    for j = 1:n_bees
        rouletteChoosed = runRoulette(f);
        v(j) = generateNewV(x,n_bees,rouletteChoosed);
        valorAtual = fitness(v(j));
        if f(j) < valorAtual
            x(j) = v(j);
            f(j) = valorAtual;
            nao_melhorou(j) = 0;
        else
            nao_melhorou(j) = nao_melhorou(j) + 1;
        end
    end
    for j = 1:n_bees
        if nao_melhorou(j) > limite
            x(j) = unifrnd(-2,2);
            f(j) = fitness(x(j));
        end
    end
    [mval,midx] = max(f);
    bestForIt(i,1) = x(midx);
    bestForIt(i,2) = mval;
end
subplot(2,1,1);
plot(bestForIt(:,1));
subplot(2,1,2);
plot(bestForIt(:,2));