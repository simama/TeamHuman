import sys
import numpy as np
import neurolab as nl
import json
import random

np.random.seed(1)

#Label Classes
NORMAL = 0
FALL   = 1

#Training Params
trainingProp = .8

def parseFeature(sample):
    return [ 0 if s == "" else float(s) for s in sample["feature_vector"].split(" ") ]

def parseOutput(sample):
    return NORMAL if sample["sample_type"] == "Normal" else FALL

##
## Read data and load JSON
##
labeledSamples = []
with open("raw_data.json", "r") as dataFile:
    labeledSamples = json.load(dataFile)["results"]

##
## Split up JSON into input features and outputs
##
inputFeatures = [parseFeature(sample) for sample in labeledSamples]
output        = [parseOutput(sample) for sample in labeledSamples]


##
## Split Train / Test
##
numSamples = len(output)
trainingSetSize = int(numSamples * trainingProp)
allIds = range(len(output))


trainIdSet = np.array(random.sample(allIds, trainingSetSize))
testIdSet = np.setdiff1d(allIds, trainIdSet)

trainInput, trainOutput = np.array([inputFeatures[i] for i in trainIdSet]), np.array([output[i] for i in trainIdSet])
testInput, testOutput = np.array([inputFeatures[i] for i in testIdSet]), np.array([output[i] for i in testIdSet])

