citiesData = load('eil51.tsp');
%Executa 100000 iterações e exibe os resultados só no final
%[solV,path] = agCaixeiro(0.5,0.2,size(citiesData,1)*2,citiesData,size(citiesData,1)*2,1000,1);
%Executa 100000 iterações e exibe os resultados passo a passo
[solV,path] = agCaixeiro(0.9,0.5,size(citiesData,1)*2,citiesData,size(citiesData,1)*2,10000,0);
%disp(round(solV));

%geracaoNovos = 0.9;
%itnumber = 10000;
%solvData = [ inf 0 0 ];
%while geracaoNovos >= 0.5
%    mutacao = 0.5;
%    while mutacao >= 0.1
%        [solV,path] = agCaixeiro(geracaoNovos,mutacao,size(citiesData,1)*2,citiesData,size(citiesData,1)*2,itnumber,0);
%        disp([solV geracaoNovos mutacao]);
%        if solV < solvData(1)
%            solvData = [solV geracaoNovos mutacao];
%        end
%        mutacao = mutacao - 0.1;
%    end
%    geracaoNovos = geracaoNovos - 0.1;
%end