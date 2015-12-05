
# coding: utf-8

# In[9]:

import numpy as np
import sys

path = "output.tmp"
with open(path, 'r') as f:
    text_scores = f.readlines()
    num_scores = [float(s) for s in text_scores]

    print "Min score is ", min(num_scores)
    print "Index of it was", np.argmin(num_scores)


# In[ ]:




# In[ ]:




# In[ ]:



