% --------------------------------------------------------------------
% Lehigh University - CSE
% CSE 326 - Machine Learning
% Gustavo Grins
% --------------------------------------------------------------------

%sources:
%http://cs231n.github.io/neural-networks-1/


%% Things to do

%code the gradients into the GD algorithm batch form
%add wo biases after the sigmoid: use the [array; 1] trick
%exclude biases from regularization terms

%bishop pg 264, I do not see the connection of thos formulas to the one
%I have


%% description of cunction

%INPUTS
%K number of hidden nodes
%X is the data
%Y are the labels

%OUTPUTS
%wh hidden weights
%wo output weights

%this method is supposed to train the NN given the data

function [wh,wo,Ctrain,Ctest,AccuTrain,AccuTest,iterations] = twoLayerNN(X,Y,...
    testDataX,testDataY,k)
%definitions
%X - input data (N by d)
%k - number of hidden nodes
%init - number of times running gradient descent ?

%% Initialization of values
labels = Y;
dimentions = size(X,2);
trainingSamples = size(Y,1);


%% initialize biases and weights
%implicit bias method
wh = -1 + (1+1)*rand(k+1,dimentions+1); %[K X d]
wo = -1 + (1+1)*rand(1,k+1); %[1 X K]

% initialize the learning rate, batch size, and regularization param
learningRate = 0.00005;
%batchSize = size(batchData,3);
lambda = 10;

%Number of iterations for the gradient descent algorithm
iterations = 1:1:50;


%% gradient descent algorithm to get optimal parameters
for i = 1:length(iterations)
    
    %% implement batch concept
    
    %implicit bias
    grad_wo = zeros(size(wo));
    grad_wh = zeros(size(wh));

    
    %do it for single values only
    for j = 1:1:trainingSamples
    
    %FEED-FORWARD implicit bias
        
    %SHOULD I MAP THIS from -1 to 1?
    data = X(j,:).'; %[d X 1]
    
    %add hidden value
    data = [data;1]; %[d+1 X 1]
    
    %1. linear combination of the first layer
    %with bias
    a = wh*data; % [K+1X1] weighted input
    %[K+1X1]=[k+1 X d+1]*[d+1X1]
    
    %2. hit it with the sigmoid
    z = sigmoid(a); %book methdod [KX1]
   %[K+1X1] = [K+1X1]
   
    %3. linear combination of the second layer
    %with bias going to the output layer
    g = wo*z;
    %[1X1] = [1XK+1]*[K+1X1]
    
    %3. hit it with the sigmoid
    t = sigmoid(g); %[1X1]
   %[1X1] = [1X1]
   
   results(j) = sigmoid(g);
        

    
    
    %% BACK-PROPAGATION
    
     %implicit bias method
     %error at the output layer
     deltaOutput = (t - labels(j)).*sigmoidPrime(g); %[1X1]
     %[1X1]    [1X1]             [1X1]
     
     %error at the hidden layer
     deltaHidden = (wo.'*deltaOutput).*sigmoidPrime(a); %[(K)X1]
     %  [K+1X1]    = ([K+1X1]*[1X1]).*[k+1X1]
   
     %evaluation of gradients
     
     %get the weights only without the biases
     wh_reg = wh(1:end-1,1:end-1);
     wo_reg = wo(1:end-1);
     
     %hidden
     grad_wh = grad_wh + deltaHidden*data.' + ...
         (lambda/trainingSamples).*sum(sum(wh_reg)); %[(K) X (d)]
     %[(K+1) X (d+1)] = [(K+1) X (d+1)] + [k+1X1]*[1Xd+1]
     
     %output
     grad_wo = grad_wo + deltaOutput*z.' + ...
         (lambda/trainingSamples).*sum(wo_reg); %[1XK+1]
     %[1Xk+1] = [1Xk+1] + [1X1]*[1Xk+1]
    


    
    end
    
    %% update the weights and bias
    


    %updating section
    wh = wh - learningRate.*grad_wh;
    
    wo = wo - learningRate.*grad_wo;
    
    %calculate the regularization terms
    %remove biases from the weight vector
    wh_reg = wh(1:end-1,1:end-1);
    wo_reg = wo(1:end-1);
    
    %% performance for training
    
    %graphing the cost function for the training data
    Ctrain(i) = (1/2)*(sum((labels - results.').^2)) + ...
        (lambda/(2*2*trainingSamples)).*sum(sum(wh_reg.^2))...
        + (lambda/(2*trainingSamples)).*sum(wo_reg.^2);
    %treshhold the values
    results(results>0) = 1;
    results(results<0) = -1;
    
    AccuTrain(i) = sum(labels == results.')/size(labels,1);
    
    %% performance for testing
    
    %feeding forward in one go

    data = testDataX.';

    %add hidden value
    data = [data;ones(size(testDataY,1),1).']; %[d+1 X 1]

    %1. linear combination of the first layer
    %with bias
    a = wh*data; % [K+1X1] weighted input
    %[K+1XN]=[k+1 X d+1]*[d+1XN]

    %2. hit it with the sigmoid
    z = sigmoid(a); %book methdod [KX1]
    %[K+1XN] = [K+1XN]

    %3. linear combination of the second layer
    %with bias going to the output layer
    g = wo*z;
    %[1XN] = [1XK+1]*[K+1XN]

    %3. hit it with the sigmoid
    t = sigmoid(g); %[1X1]
    %[1XN] = [1XN]
    
    %graphing the cost function for the training data
    Ctest(i) = (1/2)*(sum((testDataY - t.').^2)) + ...
        (lambda/(2*size(testDataY,1))).*sum(sum(wh_reg.^2)) +...
        (lambda/(2*size(testDataY,1))).*sum(wo_reg.^2);
    
    %treshhold the values
    t(t>0) = 1;
    t(t<0) = -1;
    AccuTest(i) = sum(testDataY == t.')/size(testDataY,1);
    
    
    
end
    
end

%% functions for the function


function [P] = sigmoid(a)
    
        %tanh sigmoid function
        P = tansig(a);
        
end

function [P] = sigmoidPrime(a)
    
        %tanh sigmoid function derivative
        P = (1-sigmoid(a).^2);
        
end


