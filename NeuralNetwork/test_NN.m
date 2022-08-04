% --------------------------------------------------------------------
% Lehigh University - CSE
% CSE 326 - Machine Learning
% Gustavo Grins
% --------------------------------------------------------------------

clc;
clear;
close;

%load 20ng.mat
load mnist.mat

X = double(X);

%split the data
[trainDataX,trainDataY,testDataX,testDataY] = splitData(X,Y);

k = 5;

[wh,wo,Ctrain,Ctest,AccuTrain,AccuTest,iterations] = twoLayerNN(trainDataX,trainDataY,...
    testDataX,testDataY,k);

testSamples = size(testDataY,1);
  
%feeding forward in one go

data = testDataX.';

%add hidden value
data = [data;ones(testSamples,1).']; %[d+1 X 1]

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
  
  
  
%treshhold the values
t(t>0) = 1;
t(t<0) = -1;
  
accuracy = sum(testDataY == t')/testSamples;
  
%% plotting
figure(1)
plot(iterations,Ctrain,'-b')
title('Performance of two layer Neural Network')
xlabel('Gradient descent iterations')
ylabel('Mean Squared Error')
hold on
plot(iterations,Ctest,'-r')
hold off
legend('Train Data','Test Data')

figure(2)
plot(iterations,AccuTrain,'-b')
title('Performance of two layer Neural Network (\lambda = 10, \eta = 0.00005 & 5 hidden nodes )')
xlabel('Gradient descent iterations')
ylabel('% Accuracy')
hold on
plot(iterations,AccuTest,'-r')
hold off
legend('Train Data','Test Data','location','SE')

%% Helper functions

function [P] = sigmoid(a)
    
        %tanh sigmoid function
        P = tansig(a);
        
end

%randomly split the data

function [trainDataX,trainDataY,testDataX,testDataY] = splitData(X,Y)
    
        %get the 10% index of the data
        dataSize = size(X,1);
        
        Data10Percent = round(.10*dataSize);
        
        idx = randperm(dataSize);
        
        indexToTest = (idx<=Data10Percent);
        indexToTrain = (idx>Data10Percent);
        
        trainDataX = tansig(X(indexToTrain,:));
        trainDataY = Y(indexToTrain);
        
        testDataX = tansig(X(indexToTest,:));
        testDataY = Y(indexToTest);
        
end