What is in the folder?

*twoLayerNN.m -> MNIST and 20ng data
*test_NN.m -> NIST and 20ng data

Description of twoLayerNN.m (function for test_NN):

this function is the heart of the code. It will perform forward and backward propagation on the provided data. This function implements neural network algorithm found in Pattern Recognition and Machine Learning by Christopher M. Bishop (ISBN-10: 0-387-31073-8). This function also stores arrays with the loss Function values and accuracy percantage of each epoch of the gradient descent algorithm. Note that GD works using the batch method. This method iterates through the entire data to update the gradients of the weights.

Inputs: *X data values *Y labels *testDataX *testDataY *k value # of hidden nodes 

Outputs: *wh hidden layer optimized weights *wo output layer optimized weights *Ctrain error function array per iterations *Ctest error function array per iterations *AccuTrain accuracy array per iterations *AccuTest accuracy array per iterations *iterations # of iterations "epochs" of the gradient descent

User modifications: The user of this function can change the learning rate, number of iterations for GD, and regularization parameter lambda 

Description of test_NN:

This function uses twoLayerNN.m to optimize the weights and then performs a forward path of the algorithm and plots all the performance values (which uses values that come from the twoLayerNN.m function).

Inputs: MNIST.mat or 20ng.mat

Outputs: accuracy value for the test data, graphs for MSE optimization, graph for %accuracy depending on iterations in GD.

User modifications: The user can decide what k value he or she wants for the hidden nodes. The user can also pick between the MNIST and 20ng data


