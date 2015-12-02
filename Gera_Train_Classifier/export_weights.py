import numpy as np
import sys
import pickle as pkl

##
## Parse pkl file (outputed from Python Neon) into weight vector
##
def getweights(file_name, verbose=False, debug = False):
    vec = []
    # Load a stored model file from disk (should have extension prm)
    params = pkl.load(open(file_name, 'r'))    

    weights = []
    
    for i in range(2):
        layer_index = i
        layer = params['layer_params_states'][layer_index]
        query = layer['params']['W'] 
        name = layer['params']['name']
        
        if(debug):
            print "Layer " , name
            print "Layer len()" , len(layer)
            print "Num states ", len(layer["states"][0])
            print "Width of state",len(layer["states"][0][0])
            print "Num weights", len(query)
            print "Width weights", len(query[0])
            print query
        
        for node in query:
            weights.extend(node)
    if(verbose):
        print "Expected num Weights:", 700*1921 + 700  * 2
        print "Print actual num Weights", len(weights)
        
    return weights

weights = getweights('./savefile.prm', True)


##
## Write to output path in = seperater format
##
outputPath = "weightFile.txt"
with open(outputPath, "w+") as outputFile:
    for w in weights:
        outputFile.write(str(w))
        outputFile.write(" ")



