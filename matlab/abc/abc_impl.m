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
    [x,v,f,nao_melhorou] = beeType('worker',x,v,f,nao_melhorou,limite);
    [x,v,f,nao_melhorou] = beeType('helper',x,v,f,nao_melhorou,limite);
    [x,v,f,nao_melhorou] = beeType('scout',x,v,f,nao_melhorou,limite);
    [mval,midx] = max(f);
    bestForIt(i,1) = x(midx);
    bestForIt(i,2) = mval;
end
subplot(2,1,1);
plot(bestForIt(:,1));
subplot(2,1,2);
plot(bestForIt(:,2));