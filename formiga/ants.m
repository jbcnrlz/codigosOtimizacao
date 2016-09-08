n = 7;
x = (0:0.5:3);
Tal = ones(1,length(x));
ro = 0.5;
i = 10;
ps = Tal;

while 1
    for i = 1:length(Tal)
        ps(i) = calculateP(i,Tal);
    end
    antsItem = rand(1,n);
    antsResult =  zeros(1,n);
    for i = 1:length(antsItem)
        antsItem(i) = roulette(ps,antsItem(i));
    end
    if all(antsItem == antsItem(1))
        disp([x(antsItem(1)) objectiveFunction(x(antsItem(1)))]);
        break
    end
    for i = 1:length(antsResult)
        antsResult(i) = objectiveFunction(x(antsItem(i)));
    end
    [values,idxSort] = sort(antsResult);
    idxFbest = find(antsResult==values(1));
    fBestValue = values(1:length(idxFbest));
    Tal = newTau(fBestValue,values(end),2,Tal,0.5,antsItem(idxSort(1)));
end