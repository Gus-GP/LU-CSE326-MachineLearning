% --------------------------------------------------------------------
% Lehigh University - CSE
% CSE 326 - Machine Learning
% Gustavo Grins
% --------------------------------------------------------------------

%house keeping
clc;
clear;
close all;

%using the MNIST data need to work on this
%figure out how the read the data into here
load mnist.mat;

%specify you k for k-NN
kval = 10;

for k = 1:1:kval
tic
clearvars -except k accuracy testTime kval trainY trainX testY testX

%Number of labels
Numlabels = 10;

%Method of cluster initialization (0 = random, or 1 further heuristic)
method = 1;

%get an array of different labels
labels = unique(trainY);

%% k-NN
    %get the training data
    for I = 1:1:length(labels)
        %get the current label
        currentlabel = labels(I);
        
        %find k indeces where values are equal to currentlabel
        indeces = find(trainY==currentlabel);
        
        %get the values of trainX using the indeces vy iterating
        %through this vector and obtaining all its corresponding values
        for o = 1:1:length(indeces)
            label_data(o,:) = trainX(indeces(o),:);
        end
            
        %Call Kmeans algorithm
        Centroid(:,:,I) = gusKmeans(label_data,k);
        
    end
   
    %iterate through test data and calculate the distances
    %first for loop will select all rows of data
    for i = 1:1:size(testX,1)
        for j = 1:1:k
            %for each label
            for z = 1:1:size(Centroid,3)
               %calculate the distance of the specific point to all centroids
               dist(j,z) = sqrt(((Centroid(j,:,z) - testX(i,:))*((Centroid(j,:,z) - testX(i,:))')));
            end
        end
        
        %get the 10 minimun closest distances with the label index
        %they cant be all from each label. they need to be the min overall
        
        %get the min of all the rows
        

        %write the classification here
        %MinimumofLabel = min(dist,[],1); %should return a column vector
        
        %get the minimun of the above
        [Y,index] = min(dist,[],2);
        
        %store all the indeces that have the label of each value
        %this will give me the index of label
        indexOfLabel = index;
        
        indexOfLabel = indexOfLabel - 1;
        
        %perform majority vote
        decidedLabel(i) = mode(indexOfLabel);
        
    end
    
    %check the results
    differencia = decidedLabel' - testY;
    
    %count the zeros in the array
    correctLabel = nnz(~differencia);
    
    accuracy(k) = correctLabel./size(trainX,1);
    testTime(k) = toc;
end
    
 %% Plotting
 
%graph of test time an number of K
%Score PLotting 2: k values vs distanace score
subplot(1,2,1)
plot(1:1:k,accuracy)
title('Accuracy vs. Number of clusters per class')
ylabel('Accuracy')
xlabel('Number of clusters per class')
subplot(1,2,2)
plot(1:1:k,testTime)
title('Test time vs. Number of clusters per class')
ylabel('Test time')
xlabel('Number of clusters per class')


