N = 4;
maxIter = 100;
iteHist = zeros(maxIter,1);
iteHistF = zeros(maxIter,1);
v = zeros(maxIter,N);
x = NaN(maxIter,N);
f = zeros(maxIter,N);
x(1,:) = [ -1.5 0.0 0.5 1.25 ];
i = 1;
globalBest = [-inf 0];
localBest = zeros(1,N);
while 1
    f(i,:) = fitness(x(i,:));
    [~,idx] = max(f);
    for iter = 1:length(idx)
        if f(idx(iter),iter) > globalBest(1)
            globalBest(1) = f(idx(iter),iter);
            globalBest(2) = x(idx(iter),iter);
        end        
        localBest(iter) = x(idx(iter),iter);
    end
    iteHist(i,1) = globalBest(1);
    iteHistF(i,1) = globalBest(2);
    if all(x(i,:) == x(i,1)) || i > maxIter
        disp(round(globalBest));
        break
    end
    i = i + 1;
    v(i,:) = newVelocity(v, localBest, globalBest(2), x, i);
    x(i,:) = x(i-1,:) + v(i,:);
end
subplot(1,2,1);
plot(iteHist);
subplot(1,2,2);
plot(iteHistF);