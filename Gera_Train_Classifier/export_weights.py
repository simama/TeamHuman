import numpy as np
import sys
import pickle as pkl

def layer_names(params):
    layer_names = params.keys()

#     print layer_names
#     print layer_names[0]
#     print params[layer_names[0]]
#     print layer_names[1]
#     print params[layer_names[1]]
    
    layer_names.remove('epoch_index')
    # Sort layers by their appearance in the model architecture
    # Since neon appands the index to the layer name we will use it to sort
    layer_names.sort(key=lambda x: int(x.split("_")[-1]))
    return layer_names

def getweights(file_name):
    vec = []
    # Load a stored model file from disk (should have extension prm)
    params = pkl.load(open(file_name, 'r'))    
    #layers = layer_names(params)
    print params

#     for layer in layers:
#         # Make sure our model has biases activated, otherwise add zeros here
#         b = params[layer]['biases']
#         w = params[layer]['weights']

#         newvec = np.ravel(np.hstack((b,w)))
#         [vec.append(nv) for nv in newvec]
    return vec

# An example call
#print 
getweights('./savefile.prm')
