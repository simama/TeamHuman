import sys
import numpy as np
import json
import random
import logging
from neon.callbacks.callbacks import Callbacks
from neon.data import DataIterator
from neon.initializers import Gaussian
from neon.layers import GeneralizedCost, Affine
from neon.models import Model
from neon.optimizers import GradientDescentMomentum
from neon.transforms import Rectlin, Logistic, CrossEntropyBinary, Misclassification
from neon.util.argparser import NeonArgparser
from neon.backends import gen_backend
from neon.util.argparser import NeonArgparser
# parse the command line arguments
parser = NeonArgparser()
args = parser.parse_args()

logger = logging.getLogger()
logger.setLevel(args.log_thresh)

be = gen_backend(backend=args.backend,
                 batch_size=12,
                 rng_seed=args.rng_seed,
                 device_id=args.device_id,
                 stochastic_round=False)

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

results = []
##
## Split Train / Test
##
numSamples = len(output)
trainingSetSize = int(numSamples * trainingProp)
allIds = range(len(output))


trainIdSet = np.array(random.sample(allIds, trainingSetSize))
testIdSet = np.setdiff1d(allIds, trainIdSet)

X_train, y_train = np.array([inputFeatures[i] for i in trainIdSet]), np.array([output[i] for i in trainIdSet])
X_test, y_test = np.array([inputFeatures[i] for i in testIdSet]), np.array([output[i] for i in testIdSet])
nclass = 2 ##Our classes are normal and fall

# setup a training set iterator
train_set = DataIterator(X_train, y_train, nclass=nclass)
#print ( "NUM FALLS IN TRAIN", len([i for i in  y_train if i == 1]))
# setup a validation data set iterator
valid_set = DataIterator(X_test, y_test, nclass=nclass)
#print ( "NUM FALLS IN TEST", len([i for i in y_test if i == 1]))
# setup weight initialization function
init_norm = Gaussian(loc=0.0, scale=0.01)

# setup model layers
layers = [Affine(nout=3, init=init_norm, activation=Rectlin()),
          Affine(nout=2, init=init_norm, activation=Logistic(shortcut=True))]

# setup cost function as CrossEntropy
cost = GeneralizedCost(costfunc=CrossEntropyBinary())

# setup optimizer
optimizer = GradientDescentMomentum(0.1, momentum_coef=0.9, stochastic_round=args.rounding)

# initialize model object
mlp = Model(layers=layers)
path = "./best_state_"+str(i)+".prm"
# configure callbacks
callbacks = Callbacks(mlp, train_set, eval_set=valid_set,**args.callback_args)

# add a callback that saves the best model state


callbacks.add_save_best_state_callback(path)

# print "epocs", args.epochs


# run fit
mlp.fit(train_set, optimizer=optimizer, num_epochs=15, cost=cost, callbacks=callbacks)

result_float = (mlp.eval(valid_set, metric=Misclassification()))*100
result_string ='%.1f%%' % result_float
print(result_string[:-1])
# print('Misclassification error = %.1f%%' % r)




