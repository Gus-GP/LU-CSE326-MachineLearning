What is in the folder?

*clusterInit.m -> MNIST data
*gmm.m -> MNIST data
*pca.m -> MNIST data
*testGmm.m -> MNIST data
*testPCA.m -> MNIST data

Description of ClusterInit.m (function for gmm):

this function lets the the user pick random or furthest initialization for the gmm classification algorithm.

Inputs: *k value *MNIST Data 

Outputs: *initialized k points

Description of gmm.m (function for testGmm):

This function implements Expectation Maximization algorithm for Gaussian mixture models. This algorithm can be found in Pattern Recognition and Machine Learning by Christopher M. Bishop (ISBN-10: 0-387-31073-8) pg 438-439.

Inputs: *k-cluster value *MNIST Data *initialization ('random' or 'furthest')

Outputs: *means (mu), 'full shared' variance (si2), mixture coefficients (classPi), probability of nth data belonging to cluster (z), complete log likelihood (CLL), incomplete log likelihood (ILL)

User modifications: The user of this function can increase the number of iterations for the EM algorithm by changing the variable 'numIter.' 

Description of pca.m (function for testPCA):

This function implements a principal component algorithm to improve the computing speed for the gmm algorithm. The code takes high dimentional data and turns it into a lower dimentional data reducing the computing time for the gmm classification phase.

Inputs: *k-cluster value *MNIST Data

Outputs: *Projected data in lower dimensions (Z), eigenvectos (vecs), eigen values (vals)

Description of testGmm.m:

This is the testing method for the gmm algorithm.

Inputs: k value

ouputs: CLL and ILL vs. EM iterations plot, means for ks 1-16

User modification: the user can change the variable k to decide how many clusters does she want for classification. For different types of plotting the written lines can be commented out to do the other plots.

Description of testPCA.m:

This is the testing method for the pca algorithm.

Inputs: k value

ouputs: A plot of all eigenvalues, principal component graph, plots of the first 10 eigenvectors, plots of means and mixig coefficients using gmm at k = 5 after running the MNIST data through pca algorithm.

User modification: the user can change the variable k to decide how many clusters does she want for classification.
