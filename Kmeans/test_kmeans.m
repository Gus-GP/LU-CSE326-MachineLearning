% --------------------------------------------------------------------
% Lehigh University - CSE
% CSE 326 - Machine Learning
% Gustavo Grins
% --------------------------------------------------------------------


%house keeping
clc;
clear;
close all;

%Reading the 2D data
fileID = fopen('2D_data.txt','r');
formatSpec = '%f %f';
sizeA = [2 Inf];
A = fscanf(fileID,formatSpec,sizeA);
fclose(fileID);
A = A';

%k-means
%kval = 20; this values are for k vs distance score

%initializa the k value
k = 5;

%this loop if for plotting k vs distance score
%for k = 1:1:kval

%Method of cluster initialization (0 = random else further heuristic)
method = 1;

%initialize the clusters
Centroids = clusterInit(A,k,method);

%initialize old centroids
oldCentroids = zeros(size(Centroids,1),size(Centroids,2));

iteration = 1:1:20;

%run for the nummber of time you want
for Gus = 1:1:length(iteration)
  
    %clear values for the new assignments
    clear Clusters
    
    %initialize indeces
    indeces = zeros(1,size(A,1)); 
    
    %first for loop will select all points in data
    for i = 1:1:size(A,1)
          
        %second for loop will get the centroids difference to all points
        %initialize the matrix with distances
        dist = zeros(1,k);
        
        for j = 1:1:k
           
           %calculate the distance of the specific point to all centroids
           dist(j) = sqrt(((Centroids(j,1) - A(i,1)).^2) + ((Centroids(j,2) - A(i,2)).^2));

        end

        %Find the index of the min value of all the cluster calculations
        %to that point
        [Y,index] = min(dist);
        
        %store all the indeces from the results
        indeces(i) = index;

    end
    
    %recalculate the centroid with the cluster info
    
    %save the values of the old centroids to get out of all iterations
    oldCentroids = Centroids;
    
    for i=1:1:k
        
        %select all the values row index numbers where indeces = i
        %and put it in a temporary MATRIX
        clusterValues = A(indeces==i,:);
        
        %assign values to cluster matrix
        for j = 1:1:size(clusterValues,1)
            Clusters(j,:,i) = clusterValues(j,:);
        end
             
        %number of values in this temporary MATRIX
        Ncluster = size(clusterValues,1);
        
        if Ncluster == 0
        
            %do not rewrite the cluster
        
        else
            %assign the new centroids by calculating the mean of the x and
            %y values in the cluster
            Centroids(i, :) = (1/Ncluster) * sum(clusterValues);
        
        end
        
    end
    
    
%end

%Calculate the distance score

%sum the distances of each cluster to each point
for j = 1:1:size(Clusters,3) %for all the x and y values in A
    
    %getting rid of the zeros
    cluster1 = Clusters(:,:,j);
    rowsWithZeros = any(cluster1==0, 2);
    cluster1 = cluster1(~rowsWithZeros, :);

    for i = 1:1:size(cluster1,1)
        %Calculate the distances of each centroid to each point in its cluster
        distance(i,j) = sqrt(((Centroids(j,1) - cluster1(i,1)).^2) + ((Centroids(j,2) - cluster1(i,2)).^2));
    end
    
end


%sum the colums of each cluster
summation = sum(distance,1);

Score(Gus) = sum(summation);

end

%end

%Save variables for plotting
%Kcurrent

%% Plotting section
figure(1)
scatter(A(:,1),A(:,2))
title('2D Data scatter plot')
ylabel('Y values')
xlabel('X values')


%loop plotting
figure (2)
subplot(1,2,1)
for i = 1:1:size(Clusters,3)
    %getting rid of the zeros
    cluster1 = Clusters(:,:,i);
    rowsWithZeros = any(cluster1==0, 2);
    cluster1 = cluster1(~rowsWithZeros, :);
 
    scatter(Centroids(i,1),Centroids(i,2),'red', 'filled')
    hold on
    scatter(cluster1(:,1),cluster1(:,2),'filled');
    hold on
end
title('Final iteration result')
ylabel('Y values')
xlabel('X values')
legend('Centroids')
hold off

%Score plotting
subplot(1,2,2)
plot(iteration,Score)
title('Distance Scores')
ylabel('Distance score')
xlabel('Iterations')


%Score PLotting 2: k values vs distanace score
% figure(3)
% plot(1:1:kval,Score)
% title('K value vs. Distance score')
% ylabel('Distance score')
% xlabel('K value')


