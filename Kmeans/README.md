What is in the folder?

*clusterInit.m -> 2D data
*test_kmeans.m -> 2D data
*clusterInit2.m -> MNIST data
*test_kmeans2.m -> MNIST data
*KNN_MNIST.m -> MNIST data
*gusKmeans.m -> MNIST data

Description of clusterInit.m & test_kmeans.m:

Inputs: *k value *(2D) Data

Outputs: *scatter plot of raw data *scatter plot of clustering with distance measure.

This pair of .m  files is to perform k-means on the 2D data provided. ClusterInit.m is a method in test_kmeans.m. The inputs for this method are:
*k value *(2D) Data *method

the method input is weather the user wants random or furthest initialization. For random input 0. For furthest, any number that is not 0.

After selecting the desired parameters the code should run and give you the specified outputs 

Description of clusterInit2.m & test_kmeans2.m:

Inputs: *k value *(MNIST) Data

Outputs: *Outputs of reported means for the specified k value

This pair of .m  files is to perform k-means on the MNIST data provided. ClusterInit.m is a method in test_kmeans.m. The inputs for this method are:
*k value *(2D) Data *method

the method input is weather the user wants random or furthest initialization. For random input 0. For furthest, any number that is not 0.

After selecting the desired parameters the code should run and give you the specified outputs.

Description of KNN_MNIST.m & gusKmeans.m:

Inputs: *k value *(MNIST) Data * Number of labels *method of initialization

Outputs: *Plots for Test accuracy and test time as a function of
 the number of clusters per (true) class given a max value of K

 This pair of .m  files is to perform k-NN on the MNIST data provided. gusKmeans.m is a method in KNN_MNIST.m. The inputs for this method are:
*k value *MNIST Data *method

the method input is weather the user wants random or furthest initialization for the data clusters. For random input 0. For furthest, any number that is not 0.







