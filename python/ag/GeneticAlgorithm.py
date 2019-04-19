import math, numpy as np, random

def minmax(itens):
    real_list = list(itens)
    itens.sort()
    minval = float(itens[0])
    maxval = float(itens[len(itens) - 1])
    returnOrdered = []
    divisor = maxval - minval if (maxval - minval) > 0 else 1
    for i in real_list:
        returnOrdered.append((i - minval) / divisor)
    return returnOrdered

class GA(object):
    """Class for Genetic Algorithm"""    
    def __init__(self, fitFunction, iterations, crossTax, mutationTax, populationSize, initialPopulationFunction,maxPopulation=None,updateRun=None):
        super(GA, self).__init__()
        self.fitFunction = fitFunction
        self.generateInitialPop = initialPopulationFunction
        self.iterations = iterations
        self.initPopSize = populationSize
        self.crossTax = crossTax
        self.mutationTax = mutationTax
        self.maxPopulation = maxPopulation
        self.updateRun = updateRun

    def buildRoulette(self,fitValues):
        step = 1 / len(fitValues)
        evenDist = np.arange(0,1,step)
        newEvenDist = np.zeros(evenDist.shape)
        adjustSize = 1-(fitValues / np.sum(fitValues))

        for i in range(1,len(newEvenDist)):
            newEvenDist[i] = evenDist[i] + (adjustSize[i-1] + (evenDist[i-1] + evenDist[i]))

        return newEvenDist

    def selectSubjects(self,fitValues, population):        
        roulette = self.buildRoulette(fitValues)
        selectedSolutions = math.ceil(len(population) * self.crossTax)
        selectedSolutions = np.zeros((selectedSolutions,population.shape[1]))
        selectedIndexes = []
        for i in range(len(selectedSolutions)):
            index = self.runRoulette(roulette)
            while index in selectedIndexes:
                index = self.runRoulette(roulette)

            selectedIndexes.append(index)

        return population[selectedIndexes]    

    def runRoulette(self,roulette):        
        n = 0.000002 + (roulette[-1] * random.random())
        return np.where(roulette <= n)[0][-1]

    def crossover(self,father,mother):
        son = np.full((len(father),1),-1).flatten()
        sizeSplit = math.ceil(len(father) / 3)
        son[sizeSplit:sizeSplit*2] = father[sizeSplit:sizeSplit*2]
        idxSon = idxMother = (sizeSplit*2)
        while True:
            if mother[idxMother] not in son:
                son[idxSon] = mother[idxMother]
                idxSon = (idxSon+1) % len(son)

            idxMother = (idxMother+1) % len(mother)
            if idxSon == sizeSplit:
                break

        return son.astype(np.uint64)

    def mutationInversion(self,subject):
        city1 = random.randint(0,len(subject) - 1)
        city2 = random.randint(0,len(subject) - 1)
        while city2 >= city1:
            city1 = random.randint(0,len(subject) - 1)
            city2 = random.randint(0,len(subject) - 1)

        subject[city1:city2] = subject[list(range(city2-1,city1-1,-1))]
        return subject


    def reciprocal(self,subject):
        city1 = random.randint(0,len(subject) - 1)
        city2 = random.randint(0,len(subject) - 1)
        while city2 == city1:
            city1 = random.randint(0,len(subject) - 1)
            city2 = random.randint(0,len(subject) - 1)

        subject[[city1,city2]] = subject[[city2,city1]]
        return subject

    def generateNewPopulation(self,selected):
        newPopulationSize = len(selected) * (len(selected) - 1)        
        if self.maxPopulation is not None and newPopulationSize > self.maxPopulation:
            newPopulationSize = self.maxPopulation

        numberMutation = math.ceil(len(selected[0]) * self.mutationTax)

        newPopulation = []
        for i in range(len(selected) - 1):
            newPopulation.append(self.crossover(selected[i],selected[i+1]))
            newPopulation.append(self.crossover(selected[i+1],selected[i]))
            if numberMutation > 0 and random.randint(0,1) == 1:                    
                subjectTested = random.randint(1,2)*-1
                if random.randint(0,1) == 1:
                    newPopulation[subjectTested] = self.mutationInversion(newPopulation[subjectTested])                        
                else:
                    newPopulation[subjectTested] = self.reciprocal(newPopulation[subjectTested])

                numberMutation -= 1
            if (newPopulationSize < len(newPopulation)):
                break

        return np.array(newPopulation)

    def printSol(self,sol):
        return ' '.join(list(map(str,sol)))

    def run(self):
        solState = self.generateInitialPop(self.initPopSize)        
        bestValue = [-1,100000000]
        while self.iterations > 0:
            print('Faltam %d iterações' % (self.iterations))
            fitValues = self.fitFunction(solState).flatten()
            idxsSort = np.argsort(fitValues,axis=0)
            if bestValue[1] > fitValues[idxsSort[0]]:
                bestValue[0] = solState[idxsSort[0]]
                bestValue[1] = fitValues[idxsSort[0]]

            subjectSelected = self.selectSubjects(fitValues[idxsSort],solState)
            oldbest = solState[idxsSort[:math.ceil(len(idxsSort)*0.2)]]
            solState = self.generateNewPopulation(subjectSelected)            
            solState=np.concatenate((oldbest,solState)).astype(np.uint64)
            if self.updateRun is not None:
                self.updateRun(bestValue[0])
            print('Best - %f'%(bestValue[1]))
            print(self.printSol(bestValue[0]))
            self.iterations -= 1

        return bestValue