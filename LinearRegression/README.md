Description and Instructions on gug218LinearRegression.m program:

Description: This program will use the logic behind the gradient descent 
algorithm to calculate the optimized values for weight and bias of the estimated linear regression line.
For a detailed description of the math behind the code's equations please refer to the .pdf file zipped 
with this .txt file.

Data Inputs: Provided by Matlab's Library
x: Population of US states

y: Fatal traffic accidents per US state

Parameters:
wo: initial weight value

thetao: initial bias value

epsilon: Step size of the algorithm

iterations: array with values of each integer in iteration

Instructions:

This code is pre-setup to run immediately and with no changes to it. Yet, if the user wants to tune
the gradient descent process, the epsilon value can be changed. Note that if this value is sufficiently large
the iteration process will not converge because of the scale of values of the x and y array. Therefore, the pre-set
value for epsilon is really small. Another parameter that can be change is the size of the iteration array. This
can be made larger depending on the users desire. The initial parameters of the weight and bias can also be
altered if the user wants the values to start somewhere different. 

Data Outputs:

Figure(1): Relation Between Accidents & Population using the estimated regression line

Figure(2): Convergence graph of the algorithm estimation


 

