from GeneticAlgorithm import *
from scipy.spatial.distance import euclidean
import matplotlib.pyplot as plt
import numpy as np

def plotGraph(solution):
    pc = np.array(positionCities)
    plt.scatter(pc[:,1],pc[:,2])
        
    for i in range(len(solution)):
        nIdxPlot = (i+1) % len(solution)
        currX = [pc[solution][:,1][i],pc[solution][:,1][nIdxPlot]]
        currY = [pc[solution][:,2][i],pc[solution][:,2][nIdxPlot]]
        plt.plot(currX,currY,color='r')
    plt.show()

def fockingFit(population):
    fitArray = np.zeros((len(population),1))
    for i, p in enumerate(population):
        for j in range(len(p)):
            fitArray[i] += distances[p[j],p[(j+1) % len(p)]]

    return fitArray

def generateInitialPopulation(size):
    returnPopulation = []
    for i in range(size):
        returnPopulation.append(np.random.permutation(np.arange(distances.shape[0])))

    return np.array(returnPopulation)

def loadPopulation(pathFile):
    returnValue = []
    with open(pathFile,'r') as fl:
        for f in fl:
            returnValue.append(list(map(int,f.split(' '))))

    return returnValue

def calculateDistances(population):
    for p in enumerate(population):
        for p2 in enumerate(population):
            distances[p[0],p2[0]] = euclidean(p[1:],p2[1:])

def main(population):    
    calculateDistances(population)
    ga = GA(fockingFit, 10000, 0.9, 0.5, len(population), generateInitialPopulation,len(population)*5)
    sol = ga.run()
    plotGraph(sol[0])

if __name__ == '__main__':
    positionCities = loadPopulation('eil51.tsp')
    distances = np.zeros((len(positionCities),len(positionCities)))
    main(positionCities)