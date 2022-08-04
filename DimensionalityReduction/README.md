How to Run
============


KNN w/PCA
------------------
PCA_testing.m

Loads the image dataset from the Data folder
Calls pca.m
Only needs to be run
Takes no inputs
Outputs two figures with their data also printed out

KNN w/Fourier Analysis
--------------------------------
KNN_FFT.m 

Change ‘k’ change nearest neighbors 
Change ‘w’ to change window size


RUN  NN
---------------------------------
1. Select the data set to be used for the splitDataNN() function
Note: Using the ORL_32x32.mat file the images are store in the fea matrix and the labels 
are stored in the gnd matrix. This dataset load should run always because the labels need to 
be formated in the correct way using the arrangeY() function. 

1.1. if ORL_32x32.mat is used by itself on the NN code then fea should be inputted into 
the splitDataNN()

1.2. if ORL_32x32.mat will be used for PCA then the pca function hould be uncommented
and the Z output from the pca function should be iputted into the split function

1.3. if FFT will be used uncoment the desired fft transform:

for fft_10.mat --> put ten in splitDataNN() function
for fft_20.mat --> put twenty in splitDataNN() function
for fft_30.mat --> but thirty in splitDataNN() function

This code will take a couple of seconds to run because it will run each hidden node set 
up (10, 36, and 100) for three time sand the return the average values for accuracy and 
computational time 



Modules
==========

pca.m 
----------------


Parameters: X (input Data size NxD)
	        K(Number of Principal Components)


Outputs:  Z (Projected Data in New domain)
		  Vec (Eigenvectors) 
		  Val(Eigenvalues)
	




fft_reduce .m
-----------------

Parameters: X (input Data size NxD)
			p_size(window size for fft window)

Output: fft_set(reduce data set with dimensions Nx(p_size^2))		

 




