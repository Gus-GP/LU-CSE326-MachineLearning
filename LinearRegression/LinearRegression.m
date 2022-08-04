% --------------------------------------------------------------------
% Lehigh University - Computer Science
% CSE 326 - Machine Learning
% Prof. Miaomiao
% Gustavo Grins
% --------------------------------------------------------------------

% house keeping
clear all;
close all;
clc;

% data is provided in matlab
load accidents
x = hwydata(:,14); %Population of states
y = hwydata(:,4); %Accidents per state

% include your own gradient decent of linear regression here

%Initial Parameters
wo = 0;
thetao = 0;

%descent step size
epsilon = 0.0000000000000001;

%Number of iterations for the algorithm
iterations = 1:1:100;


%calculate the bias and the weight using the partial derivatives and
%the gradient descent algorithm

for i = 1:length(iterations)
    
    %weight value
    w(i) = wo - epsilon.*sum((y-(wo.*x+thetao)).*(-x));
    %bias value
    theta(i) = thetao - epsilon.*sum((y-(wo.*x+thetao)));
    
    %Convergence graph value
    E(i) = sum((y - (w(i).*x+theta(i))).^2);
    
    %update starting value
    wo = w(i);
    thetao = theta(i);
    
end

%Plotting section
figure(1)
scatter(x, y)
title('Relation Between Accidents & Population')
xlabel('Population of states')
ylabel('Fatal traffic accidents per state')
hold on
plot(x, w(end)*x+theta(end) ) 
hold off
figure(2)
plot(iterations,E)
title('Convergence graph of the algorithm estimation')
xlabel('Iterations')
ylabel('Energy function')

