% --------------------------------------------------------------------
% Lehigh University - CSE
% CSE 326 - Machine Learning
% Gustavo Grins
% --------------------------------------------------------------------


%house keeping
clc;
clear;
close all;

%figure out how the read the data into here
load mnist.mat;

%k-means
k = 15;

%Method of cluster initialization (0 = random, or 1 further heuristic)
method = 1;

%initialize the clusters
Centroids = clusterInit2(trainX,k,method);

%% k-means

%initialize old centroids
oldCentroids = zeros(size(Centroids,1),size(Centroids,2));

for N = 1:1:20
%while ~ismembertol(Centroids,oldCentroids)
    
    %clear values for the new assignments
    clear Clusters
    
    %initialize indeces
    indeces = zeros(1,size(trainX,2)); 
    
    %first for loop will select all rows of data
    for i = 1:1:size(trainX,1)
          
        %second for loop will get the centroids difference to all points
        %initialize the matrix with distances
        dist = zeros(1,k);
        
        for j = 1:1:k
           
           %calculate the distance of the specific point to all centroids
           dist(j) = sqrt(((Centroids(j,:) - trainX(i,:))*((Centroids(j,:) - trainX(i,:))')));

        end

        %Find the index of the min value of all the cluster calculations
        %to that point
        [Y,index] = min(dist);
        
        %store all the indeces from the results
        indeces(i) = index;

    end
    
    %recalculate the centroid with the cluster info
    %save the values of the old centroids
    oldCentroids = Centroids;

    for i=1:1:k
        
        %select all the values row index numbers where indeces = i
        %and put it in a temporary MATRIX
        clusterValues = trainX(indeces==i,:);
        
        %number of values in this temporary MATRIX
        Ncluster = size(clusterValues,1);
        
        if Ncluster == 0
            
        else
            %assign the new centroids by calculating the mean of the x and
            %y values in the cluster
            Centroids(i, :) = (1/Ncluster) * sum(clusterValues,1);
        end
        
    end
    
end


%% Plotting section

%this bit of code obtained (but was modified) from 
%https://blogs.mathworks.com/loren/2015/08/04/artificial-neural-networks-for-beginners/

%check if k is even or not 
if mod(sqrt(k), 1) == 0
    
    ro = sqrt(k);
    col = sqrt(k);
    
else
    
    %find all divisors get the greatest
        K2=1:1:k;
        D = K2(rem(k,K2)==0);
        ro = D(length(D)-1);
        col = k./ro;
    
end

figure(1)                                          % plot images
%colormap(gray)                                  % set to grayscale
for i = 1:1:k                                    % preview first 25 samples
    subplot(col,ro,i)                              % plot them in 6 x 6 grid
    digit = reshape(Centroids(i,:), [28,28])';    % row = 28 x 28 image
    imagesc(digit)                              % show the image
end

